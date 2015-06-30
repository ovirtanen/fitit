function match_scale_factors_to_ds(obj,nds)
%MATCH_SCALE_FACTORS_TO_DS Set the number of scale parameters to match the
%number of loaded datasets
%
%   OVERRIDES Scattering_model.match_scale_factors_to_ds
%   
%   match_scale_factors_to_ds(nds) adjusts the number of parameters
%   required to do a global fit on multiple datasets. For example if the
%   model has one "amplitude" parameter A (encompassing scattering contrast
%   and the number of particles) match_scale_factors_to_ds(3) will
%   replicate entries of A so that there will be 3 parameters A1, A2 and
%   A3, so that three datasets can be fitted simultaneously.
%
% Parameters
% nds           number of datasets
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

%% Do some initial checks

Lib.inargtchck(nds,@(x) all([numel(nds) == 1 isfloat(x) x >= 1 rem(x,1) == 0]));

sprs = obj.scale_param_rows;

if nds == numel(sprs)
    
    return;
    
end

if not(all(diff(sprs) == 1))

    error('Scale parameters should be on consecutive rows in obj.params.');
    
end

%% Change the number of scale parameters
    
pos = min(sprs);            % position in obj.params
prms = obj.params;
enabled = obj.enabled(:)';

sps = prms(sprs,:);         % scale parameters
prms(sprs,:) = [];

pns = obj.p_name_strings;   % parameter names
spns = pns(sprs);           % scale parameter names
pns(sprs) = [];

pids = obj.p_ids;           % parameter ids
spids = pids(sprs);         % scale parameter ids
pids(sprs) = [];

if nds < numel(sprs)    % reduce
    
    delta = numel(sprs) - nds;
    sps = sps(1:size(sps,1) - delta,:);
    
    spns = spns(1:size(spns,1) - delta,:);
    
    spids = spids(1:size(spids,1) - delta,:);
    
    enabled = enabled(1:numel(enabled) - delta);
    
elseif nds > numel(sprs) % increase
    
    delta = nds - numel(sprs);
    sps = [sps; repmat(sps(end,:),delta,1)];
    
    spns = [spns; repmat(spns(end,:),delta,1)];
    
    % parameter ids need to have a number appended to them
    rpids = repmat(spids(end,:),delta,1);
    spids = [spids; rpids];
    
    % if any number exist at the end of the amplitude parameters, remove
    % them
    
    e_inds = cellfun(@(x) regexp(x,'\d*$'),spids,'UniformOutput',false);

    if any(cellfun(@isempty,e_inds))
       
        e_inds = cellfun(@(x) length(x)+1,spids,'UniformOutput',false);
        
    end
    
    spids = cellfun(@(x,y) x(1:y-1), spids,e_inds,'UniformOutput',false);
    
    ns = cellfun(@num2str,num2cell(1:size(spids,1))','UniformOutput',false);
    spids = strcat(spids,ns);
    
    enabled = [enabled false(1,delta)];
    
end
    
if pos == 1
   
    prms = [sps; prms];
    pns = [spns; pns];
    pids = [spids; pids];
    
else
    
    prms = [prms(1:pos-1,:); sps; prms(pos:end,:)];
    pns = [pns(1:pos-1,:); spns; pns(pos:end,:)];
    pids = [pids(1:pos-1,:); spids; pids(pos:end,:)];
    
end

obj.scale_param_rows = pos:pos+size(sps,1)-1;
obj.params = prms;
obj.enabled = enabled;
obj.p_name_strings = pns;
obj.p_ids = pids;

keyset = obj.param_ids_to_tags(obj.p_ids,'params');
valueset = num2cell(1:numel(keyset));
            
obj.param_map = containers.Map(keyset(:),valueset);


end

