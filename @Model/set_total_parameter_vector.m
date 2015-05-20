function set_total_parameter_vector(obj,p)
%SET_TOTAL_PARAMETER_VECTOR Sets all Scattering_model and Distribution
%parameters in the Model
%   
%   set_total_parameter_vector(p)
%
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.
    
obj.bg.set_param('bg_val',p(1));
    
p(1) = [];

if numel(obj.s_models) == 1
    
    obj.s_models{1}.set_param_vector(p);
   
   return;

end

for i = 1 : numel(obj.s_models)
    
    sm = obj.s_models{i};
    np = numel(sm.p_ids) + numel(sm.dist.p_ids);
    
    sm.set_param_vector(p(1:np));
    p(1:np) = [];
    
end % for


end

