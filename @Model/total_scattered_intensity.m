function [i_mod] = total_scattered_intensity(obj,nc,q)
%TOTAL_SCATTERED_INTENSITY Total scattered intensity of all
%Scattering_models and background for one dataset
%   
%   i_mod = total_scattered_intensity(nc,q)
%
%   Parameters
%   nc          number of integration points for the PSD
%   q           scattering vector magnitudes
%   
%   Returns
%   i_mod       Total scattering intensity
%
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

i_mod = zeros(numel(q),1);

handles = obj.handles;
p = obj.get_total_parameter_vector();

for i = 1:numel(handles)

    i_mod = i_mod + handles{i}(nc,q,p);
    
end % for


end