function i_mod = scattered_intensity(obj,nc,q,p)
%SCATTERED_INTENSITY Scattered intensity for the Stieger microgel model
%   i_mod = scattered_intensity(nc,q,p)
%
%   Parameters
%   nc          Number of collcation points for the distribution
%   q           Scattering vector magnitudes
%   p           Parameter vector p, where
%                   p(1)        Scattering amplitude
%                   p(2)        Surface fuzziness (nm)
%                   p(3:end)    Parameters for the PSD
%
%   Returns
%   i_mod       Scattered intensity at points q

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

a = p(1);
f = p(2) ./ 100;

[rpsd,psd,w] = obj.dist.psd(nc,p(3:end));

% Numerical integration over the distribution using the mid-point rule

qr = (1-f) .* rpsd(:) * q(:)';                              % hard box radius
psdw = psd(:) * (w .* ones(1,numel(q)));
V2 = ((4./3.*pi.*rpsd(:).^3) * ones(1,numel(q))).^2;    % scattering weight

nw = sum((4./3.*pi.*rpsd(:)'.^3).^2 * psd(:) .* w);
f = f .* rpsd(:) * ones(1,numel(q)) ./4; 
q = ones(numel(rpsd),1) * q(:)';

i_mod = a./nw .* sum(psdw .* V2 .* obj.p_mg_stieger(qr,q,f))'; 

end

