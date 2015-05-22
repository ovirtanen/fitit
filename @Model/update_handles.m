function update_handles(obj)
%UPDATE_HANDLES Creates a handle set for calculating the total scattered
%intensity. Implements special features such as SLS backreflection and q
%smearing due to instrument resolution function.
%   
% update_handles()
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

%% Parameter vector start index
% Start index of the parameters for the scattering models in parameter
% vector p. Background and backreflection both reserve one place at the
% beginning of p, so that scattering models' parameters start at p(3) if both
% are in use.

ps = 1 + double(obj.bg.enabled) + double(not(isempty(obj.sls_br)) && obj.sls_br.enabled);


%% Create SM handles

if false && not(isempty(obj.sls_br)) && obj.sls_br.enabled % q smearing & backreflection
    
    % Implement q smearing here. In the place of false use q smearing
    % enabled check.
    
elseif not(isempty(obj.sls_br)) && obj.sls_br.enabled % backreflection
    
    sms = obj.s_models;
    
    handles = cell(1 + numel(sms),1); % +1 for accomodating background
    
    fq = @(x) obj.sls_br.q_brefl(x);
    
    for i = 1:numel(sms)
            
        sm = sms{i};
        np = numel(sm.p_ids) + numel(sm.dist.p_ids); % number of parameters for the model 
        
        h = @(nc,q,p) sm.scattered_intensity(nc,q,p(ps:ps+np-1)) + p(ps-1) .* sm.scattered_intensity(nc,fq(q),p(ps:ps+np-1));
        
        handles{i} = h;
        ps = ps + np;
           
    end % for
    
else % neither
    
    sms = obj.s_models;
    
    handles = cell(1 + numel(sms),1); % +1 for accomodating background
    
    for i = 1:numel(sms)
   
        sm = sms{i};
        np = numel(sm.p_ids) + numel(sm.dist.p_ids); % number of parameters for the model

        h = @(nc,q,p) sm.scattered_intensity(nc,q,p(ps:ps+np-1));
        
        handles{i} = h;
        ps = ps + np;
           
    end % for    
    
end

%% Background

if obj.bg.enabled
    
    handles{end} = @(nc,q,p) p(1);

else
    
    handles(end) = [];
    
end % if

obj.handles = handles;

end

