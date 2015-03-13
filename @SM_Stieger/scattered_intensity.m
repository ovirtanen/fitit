function i_mod = scattered_intensity(obj,nc,q,p)
%SCATTERED_INTENSITY Scattered intensity for the Stieger microgel model
%   i_mod = scattered_intensity(nc,q,p)
%
%   Parameters
%   nc          Number of collcation points for the distribution
%   q           Scattering vector magnitudes
%   p           Parameter vector p, where
%                   p(1)        Scattering amplitude
%                    p(2)        Surface fuzziness (nm)
%                   p(3:end)    Parameters for the PSD
%
%   Returns
%   i_mod       Scattered intensity at points q


a = p(1);
f = p(2);

[rpsd,psd,w] = obj.dist.psd(nc,p(3:end));

% Numerical integration over the distribution using the mid-point rule

qr = rpsd(:) * q(:)';
psdw = psd(:) * (w .* ones(1,numel(q)));
q = ones(numel(rpsd),1) * q(:)';

i_mod = a .* sum(psdw .* obj.p_mg_stieger(qr,q,f))'; 

end

