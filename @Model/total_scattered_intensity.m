function [i_mod] = total_scattered_intensity(obj,nc,q)
%TOTAL_SCATTERED_INTENSITY Total scattered intensity of all
%Scattering_models and background
%   
%   i_mod = total_scattered_intensity(nc,q)
%
%   Parameters
%   nc          number of collocation points for the PSD
%   q           scattering vector magnitudes
%   
%   Returns
%   i_mod       Total scattering intensity
%
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

i_mod = zeros(numel(q),1);

for i = 1:numel(obj.s_models)
   
    sm = obj.s_models(i);
    p = obj.get_total_s_model_param_vector(sm);
    i_mod = i_mod + sm.scattered_intensity(nc,q,p);
    
end % for

i_mod = i_mod + obj.bg.scattered_intensity();

end