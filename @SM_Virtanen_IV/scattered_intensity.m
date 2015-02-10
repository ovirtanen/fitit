function i_mod = scattered_intensity(obj,nc,q,p)
%SCATTERED_INTENSITY Scattered intensity for the Stieger microgel model
%   i_mod = scattered_intensity(nc,q,p)
%
%   Parameters
%   nc          Number of collcation points for the distribution
%   q           Scattering vector magnitudes
%   p           Parameter vector p, where
%                   p(1)        Scattering amplitude
%                   p(2)        Penetration depth
%                   p(3)        Shell thickness
%                   p(4)        Core PD
%                   p(5)        Max skin PD
%                   p(6)        Surface fuzziness (nm)
%                   p(7:end)    Parameters for the PSD
%
%   Returns
%   i_mod       Scattered intensity at points q


a = p(1);
pnd = p(2);
sthck = p(3);
vcore = p(4);
vskin = p(5);
fuzz = p(6);

[rpsd,psd,w] = obj.dist.psd(nc,p(7:end));

% Numerical integration over the distribution using the mid-point rule

i_mod = zeros(numel(q),1);

for p = 1:numel(psd)

    [rprf, prf] = SM_Virtanen_IV.pd_profile(nc,pnd,rpsd(p),sthck,vcore,vskin,fuzz);
    i_mod = i_mod + a .* psd(p).* Scattering_model_spherical.vnumP(rprf,w,prf,q) .* w;
    
end % for

end

