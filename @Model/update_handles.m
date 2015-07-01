function update_handles(obj)
%UPDATE_HANDLES Creates a handle set for calculating the total scattered
%intensity. Implements special features such as SLS backreflection and q
%smearing due to instrument resolution function.
%   
% update_handles()
%
% Structure of the parameter vector
% 
% p = 
%   [bg1 bg2 .. bgn br1 br2 .. brm p1 p2 ..pk]'
%
% There can be maximum numel(Model.data_sets) backgrounds and
% backreflections. Some of them or all of them might not be present in p if
% they are not enabled.
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

%% Book keeping

% number of backgrounds
ebg = obj.bg.enabled;
nbg = ebg(ebg == true);
nbg = numel(nbg);

% number of backreflections
if not(isempty(obj.sls_br))
   
    ebr = [obj.sls_br.enabled];
    nbr = ebr(ebr == true);
    nbr = numel(nbr);
    
else
    
    nbr = 0;
    
end


ds = obj.data_sets;
sms = obj.s_models;
handles = cell(nbg + numel(ds) .* numel(sms),1); % + nbg for accomodating backgrounds

for d = 1:max(1,numel(ds))
    
    % Parameter vector start index
    % Start index of the parameters for the scattering models in parameter
    % vector p. Background and backreflection both reserve places at the
    % beginning of p, so that scattering models' parameters start after them

    ps = 1 + nbg + nbr;
    a_handles = [];
    
    %% Background

    if ebg(d)
        
        handles{sum(ebg(1:d))} = @(nc,q,p) p(ps-(nbg+1-sum(ebg(1:d)) + nbr));
        a_handles = [a_handles sum(ebg(1:d))];


    end % if
    
    %% Create SM handles
    
    if false && not(isempty(obj.sls_br)) && obj.sls_br(d).enabled % q smearing & backreflection

        % Implement q smearing here. In the place of false use q smearing
        % enabled check.

    elseif not(isempty(obj.sls_br)) && numel(obj.sls_br) >= d && obj.sls_br(d).enabled % backreflection enabled for this ds

        fq = @(x) obj.sls_br(d).q_brefl(x);

        for i = 1:numel(sms)

            sm = sms{i};
            np = numel(sm.p_ids) + numel(sm.dist.p_ids); % number of parameters for the model 
            
            % parameter indices in the total parameter vector p
            pinds = ps:ps+np-1;
            % remove amplitude parameters that are not for this data_set
            spr = sm.scale_param_rows;
            spr(d) = [];
            pinds(spr) = [];

            h = @(nc,q,p) sm.scattered_intensity(nc,q,p(pinds)) + p(ps-(nbr+1-sum(ebr(1:d)))) .* sm.scattered_intensity(nc,fq(q),p(pinds));

            handles{nbg + (d-1) .* numel(sms) + i} = h;
            ps = ps + np;

        end % for

    else % neither
        
        for i = 1:numel(sms)

            sm = sms{i};
            np = numel(sm.p_ids) + numel(sm.dist.p_ids); % number of parameters for the model
            
            % parameter indices in the total parameter vector p
            pinds = ps:ps+np-1;
            % remove amplitude parameters that are not for this data_set
            spr = sm.scale_param_rows;
            spr(d) = [];
            pinds(spr) = [];
            
            h = @(nc,q,p) sm.scattered_intensity(nc,q,p(pinds));

            handles{nbg + (d-1) .* numel(sms) + i} = h;
            ps = ps + np;

        end % for    

    end
    
    a_handles = [a_handles nbg + (d-1) .* numel(sms) + (1:numel(sms))];
    
    if not(isempty(ds))
        
        ds(d).set_active_handles(a_handles);
        
    end
    
end % ds for

obj.handles = handles;

end

