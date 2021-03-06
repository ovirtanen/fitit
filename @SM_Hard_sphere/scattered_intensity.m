function i_mod = scattered_intensity(obj,nc,q,p)
%SCATTERED_INTENSITY Scattered intensity of hard spheres
%   i_mod = scattered_intensity(nc,q,p)
%
%   Parameters
%   nc          Number of integration points for the distribution
%   q           Scattering vector magnitudes
%   p           Parameter vector p, where
%                   p(1)        Scattering amplitude
%                   p(2:end)    Parameters for the PSD
%
%   Returns
%   i_mod       Scattered intensity at points q

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

a = p(1);

[rpsd,psd,w] = obj.dist.psd(nc,p(2:end));

% Numerical integration over the distribution using the mid-point rule

qr = rpsd(:) * q(:)';
psdw = psd(:) * (w .* ones(1,numel(q)));

% normalization weight to cancel the scattering weight V(R).^2
nw = sum((4./3.*pi.*rpsd(:).^3).^2 .* psd(:) .* w);

i_mod = a./ nw .* sum(psdw .* ((4./3.*pi.*rpsd(:).^3) * ones(1,numel(q))).^2 .* SM_Hard_sphere.f_hard_sphere(qr).^2)'; 



end

