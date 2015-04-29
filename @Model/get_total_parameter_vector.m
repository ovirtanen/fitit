function p = get_total_parameter_vector(obj)
%GET_TOTAL_PARAMETER_VECTOR Combined parameter vector for all the
%Scattering_models and their distributions
%   
%   p = get_total_parameter_vector()
%
%   Returns
%   p           Total parameter vector
%               p : [bg p1; p2; ... pn], where p1..pn are total parameter
%               vectors for Scattering_models 1..n in the model and bg the
%               background scattering
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

p = obj.bg.get_param('bg_val');

if numel(obj.s_models) == 1
    
    p = [p; obj.get_total_s_model_param_vector(obj.s_models)];
    return;
    
end

for i = 1:numel(obj.s_models)
    
    sm = obj.s_models(i);
    p = [p; get_total_s_model_param_vector(sm)];
    
end

end

