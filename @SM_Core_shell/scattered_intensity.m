function i_mod = scattered_intensity(obj,nc,q,p)
%SCATTERED_INTENSITY Scattered intensity of core shell particle
%   i_mod = scattered_intensity(nc,q,p)
%
%   Parameters
%   nc          Number of collcation points for the distribution
%   q           Scattering vector magnitudes
%   p           Parameter vector p, where
%                   p(1)        Scattering amplitude
%                   p(2)        Fractional radius of the core
%                   p(3)        Polarization density of the core
%                   p(4)        Polarization density of the shell
%                   p(5:end)    Parameters for the PSD
%
%   Returns
%   i_mod       Scattered intensity at points q
%
%   Pedersen, J. S. Advances in Colloid and Interface Science 1997, 70, 171?210.

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

a = p(1);
frc = p(2);
pdc = p(3);
pds = p(4);

[rpsd,psd,w] = obj.dist.psd(nc,p(5:end));

% Numerical integration over the distribution using the mid-point rule

% r = [r1 r1 r1 ... r1          q = [q1 q2 q3 ... qn
%      r2 r2 r2 ... r2               q1 q2 q3 ... qn
%       . .  .      .                .  .  .      .
%      rn rn rn ... rn]              q1 q2 q3 ... qn]
%

rt = rpsd(:) * ones(1,numel(q));                            % total particle radius
rc = frc ./ 100 .* rt;                                      % core radius

psdw = psd(:) * (w .* ones(1,numel(q)));                    % PSD and quadrature weight

% Scattering weight normalizer. Dividing the scattered intensity with the
% normalizer normalizes the integral of the (scattering mass)^2 weighted PSD
% to 1, resulting in P(0) = 1.

swn = sum(SM_Core_shell.m3(rpsd(:),frc./100.*rpsd(:),pds,pdc).^2 .*w .* psd(:)); 

q = ones(numel(rpsd),1) * q(:)';

i_mod = a ./swn .* sum(psdw  .* SM_Core_shell.m3(rt,frc./100.*rt,pds,pdc).^2 .*  SM_Core_shell.f3(q,rt,rc,pds,pdc).^2)';


end

