function set_total_parameter_vector(obj,p)
%SET_TOTAL_PARAMETER_VECTOR Sets all Scattering_model and Distribution
%parameters in the Model
%   
%   set_total_parameter_vector(p)
%
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

%% Starting index for scattering models' parameters

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

ps = 1 + nbg + nbr;

%% Background

if nbg > 0
    
    obj.bg.set_param_vector(p(1:nbg));
    
end
  
%% Backreflection

if nbr > 0
    
    for i = 1:nbr
        
        obj.sls_br(i).set_param_vector(p(nbg+i));
        
    end
    
end

%% Scattering models

for i = 1 : numel(obj.s_models)
    
    sm = obj.s_models{i};
    np = numel(sm.p_ids) + numel(sm.dist.p_ids);
    
    % parameter indices in the total parameter vector p
    pinds = ps:ps+np-1;
    
    sm.set_param_vector(p(pinds));
    ps = ps + np;
    
end % for


end

