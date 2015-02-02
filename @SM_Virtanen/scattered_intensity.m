function i_mod = scattered_intensity(obj,nc,q,p)
%SCATTERED_INTENSITY Scattered intensity for the Stieger microgel model
%   i_mod = scattered_intensity(nc,q,p)
%
%   Parameters
%   nc          Number of collcation points for the distribution
%   q           Scattering vector magnitudes
%   p           Parameter vector p, where
%                   p(1)        Scattering amplitude
%                   p(2)        Decay rate
%                   p(3)        Max skin PD
%                   p(4)        Surface fuzziness (nm)
%                   p(5:end)    Parameters for the PSD
%
%   Returns
%   i_mod       Scattered intensity at points q


a = p(1);
drate = p(2);
vskin = p(3);
fuzz = p(4);

[rpsd,psd,w] = obj.dist.psd(nc,p(5:end));

% Numerical integration over the distribution using the mid-point rule

i_mod = zeros(numel(q),1);

for p = 1:numel(psd)
    
    [rprf, prf] = SM_Virtanen.pd_profile(nc,rpsd(p),drate,vskin,fuzz);
    i_mod = i_mod + a .* psd(p).* SM_Virtanen.vnumP(rprf,w,prf,q) .* w;
    
end % for

end

