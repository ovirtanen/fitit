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

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

a = p(1);
drate = p(2);
vskin = p(3);
fuzz = p(4);

[rpsd,psd,w] = obj.dist.psd(nc,p(5:end));

% Numerical integration over the distribution using the mid-point rule

i_mod = zeros(numel(q),1);
smn = zeros(numel(psd),1);        % collect all scattering masses to calculate the scattering mass normalizer

for f = 1:numel(psd)
    
    [rprf,prf,wprf] = SM_MG_numerical.pd_profile(nc,rpsd(f),drate,vskin,fuzz);
    [pf,smf] = Scattering_model_spherical.vnumP(rprf,wprf,prf,q);
    smn(f) = smf;
    i_mod = i_mod + psd(f) .* w .* smf.^2 .* pf ;
    
end % for

smn = w .* psd(:)' * smn(:).^2;

i_mod = a ./ smn .* i_mod;

end

