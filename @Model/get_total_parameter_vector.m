function p = get_total_parameter_vector(obj)
%GET_TOTAL_PARAMETER_VECTOR Combined parameter vector for all the
%Scattering_models and their distributions
%   
%   p = get_total_parameter_vector()
%
%   Returns
%   p           Total parameter vector
%               p : [bg p1; p2; ... pn], where p1..pn are total parameter
%               vectors for Scattering_models 1..n in the model. The first
%               entry is background (bg) if bg is enabled in SM_Background,
%               otherwise p: [p1; p2; ... pn]
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

sms = obj.s_models;

if obj.bg.enabled
    
    p = obj.bg.get_param('bg_val');
    
else
    
    p = [];
    
end

for i = 1:numel(sms)
    
    sm = sms{i};
    p = [p; obj.get_total_s_model_param_vector(sm)];
    
end

end

