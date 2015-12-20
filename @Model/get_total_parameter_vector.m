function p = get_total_parameter_vector(obj)
%GET_TOTAL_PARAMETER_VECTOR Combined parameter vector for all the
%Scattering_models and their distributions
%   
%   p = get_total_parameter_vector()
%
%   Returns
%   p           Total parameter vector
%               p : [bg1 bg2 .. bgn br1 br2 .. brn p1; p2; .. pk], where bg 
%               are the enabled backgrounds for maximum n loaded datasets,
%               br are the enabled backreflections for maximum n datasets
%               and p are the total parameter vectors for k scattering
%               models. 

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

sms = obj.s_models;
p = [];

%% Background
bg_enabled = obj.bg.enabled;

if any(bg_enabled)
    
    bg_vals = cell2mat(obj.bg.params(:,2));
    
    p = [p; bg_vals(bg_enabled)];
    
end
  
%% Backreflection

brs = obj.sls_br;

if not(isempty(brs)) && any([brs.enabled])
    
    etas = {brs.eta};
    etas = cellfun(@(x)x{2},etas([brs.enabled]));
    p = [p; etas(:)];
    
end

%% Scattering models

for i = 1:numel(sms)
    
    sm = sms{i};
    p = [p; obj.get_total_s_model_param_vector(sm)];
    
end

end

