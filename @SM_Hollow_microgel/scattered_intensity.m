function i_mod = scattered_intensity(obj,nc,q,p)
%SCATTERED_INTENSITY Scattered intensity of hollow microgels
%   i_mod = scattered_intensity(nc,q,p)
%
%   Parameters
%   nc          Number of integration points for the distribution
%   q           Scattering vector magnitudes
%   p           Parameter vector p, where
%                   p(1)        Scattering amplitude
%                   p(2)        Decay rate of the profile
%                   p(3:end)    Parameters for the PSD
%
%   Returns
%   i_mod       Scattered intensity at points q

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

a = p(1);
dr = 10.^p(2);

[rpsd,psd,w] = obj.dist.psd(nc,p(3:end));

% Numerical integration over the distribution using the mid-point rule

psdw = psd(:) * (w .* ones(1,numel(q)));

% normalization weight to cancel the scattering weight V(R).^2
nw = (obj.V(rpsd(:)',dr)).^4  * psd(:) .* w;

i_mod = a./ nw .* sum(psdw .* (obj.V(rpsd(:),dr) * ones(1,numel(q))).^2 .* obj.f_hmg(q,rpsd,dr).^2)'; 



end

