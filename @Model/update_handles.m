function update_handles(obj)
%UPDATE_HANDLES Creates a handle set for calculating the total scattered
%intensity. Implements special features such as SLS backreflection and q
%smearing due to instrument resolution function.
%   
% update_handles()
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

%% Book keeping

% number of backgrounds
ebg = [obj.bg.enabled];
nbg = ebg(ebg ~= 0);
nbg = numel(nbg);

% number of backreflections
if not(isempty(obj.sls_br))
   
    ebr = [obj.sls_br.enabled];
    nbr = ebr(ebr ~= 0);
    nbr = numel(nbr);
    
else
    
    nbr = 0;
    
end

% Parameter vector start index
% Start index of the parameters for the scattering models in parameter
% vector p. Background and backreflection both reserve places at the
% beginning of p, so that scattering models' parameters start after them

ps = 1 + nbg + nbr;


ds = obj.data_sets;
sms = obj.s_models;
handles = cell(numel(ds) + numel(ds) .* numel(sms),1); % + numel(ds) for accomodating backgrounds

for d = 1:max(1,numel(ds))

    a_handles = [];
    
    %% Create SM handles
    
    if false && not(isempty(obj.sls_br)) && obj.sls_br(d).enabled % q smearing & backreflection

        % Implement q smearing here. In the place of false use q smearing
        % enabled check.

    elseif not(isempty(obj.sls_br)) && numel(obj.sls_br) >= d && obj.sls_br{d}.enabled % backreflection enabled for this ds

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
            
            h = @(nc,q,p) sm.scattered_intensity(nc,q,p(pinds)) + p(ps-(nbr+1)+d) .* sm.scattered_intensity(nc,fq(q),p(pinds));

            handles{(d-1) .* numel(sms) + i} = h;
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

            handles{(d-1) .* numel(sms) + i} = h;
            ps = ps + np;

        end % for    

    end
    
    a_handles = (d-1) .* numel(sms) + (1:numel(sms));

    %% Background

    if obj.bg(d).enabled
        
        handles{max(1,numel(ds)) .* numel(sms) + d} = @(nc,q,p) p(ps-(nbg+nbr+1)+d);
        
        a_handles = [a_handles (max(1,numel(ds)) .* numel(sms) + d)];

        max(1,numel(ds)) .* numel(sms) + d

    end % if
    
    if not(isempty(ds))
        
        ds(d).set_active_handles(a_handles);
        
    end
    
end % ds for

handles(cellfun(@isempty,handles)) = []; 

obj.handles = handles;

end

