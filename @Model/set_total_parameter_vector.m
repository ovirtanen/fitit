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

ps = 1 + double(obj.bg.enabled) + double(not(isempty(obj.sls_br)) && obj.sls_br.enabled);

%% Background

if obj.bg.enabled
    
    obj.bg.set_param_vector(p(1));
    
end
  
%% Backreflection

if not(isempty(obj.sls_br)) && obj.sls_br.enabled
    
    obj.sls_br.set_param_vector(p(ps-1));
    
end

%% Scattering models

for i = 1 : numel(obj.s_models)
    
    sm = obj.s_models{i};
    np = numel(sm.p_ids) + numel(sm.dist.p_ids);
    
    sm.set_param_vector(p(ps:ps+np-1));
    ps = ps + np;
    
end % for


end

