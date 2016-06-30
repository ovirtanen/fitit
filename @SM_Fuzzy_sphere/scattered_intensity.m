function i_mod = scattered_intensity(obj,nc,q,p)
%SCATTERED_INTENSITY Scattered intensity of core shell particle
%   i_mod = scattered_intensity(nc,q,p)
%
%   Parameters
%   nc          Number of collcation points for the distribution
%   q           Scattering vector magnitudes
%   p           Parameter vector p, where
%                   p(1)        Amplitude (cm-1)
%                   p(2)        Sigma parameter
%                   p(3:end)    Parameters for the PSD
%
%   Returns
%   i_mod       Scattered intensity at points q
%
%   I. Berndt, J.S. Pedersen, P. Lindner, W. Richtering, Langmuir 22 (2006) 459.
%   M. Stieger, W. Richtering, J.S. Pedersen, P. Lindner, J. Chem. Phys. 120 (2004) 6197.

% Copyright (c) Otto Virtanen and Arjan Gelissen 2016
% All rights reserved.

a = p(1);
sigma_core_frac = p(2);
%vfc = p(5);             % relative contrast of the core

[rpsd,psd,~] = obj.dist.psd(nc,p(3:end));
intst = zeros(size(q));
normalizer = 0;

for i = 1 : numel(rpsd)
    
    r_tot = rpsd(i);
    
    sigma_core = r_tot * sigma_core_frac / 2;
    r = r_tot - sigma_core;
    
    % Volume of core
    v_core = 4*pi*(r.^3/3 + r * sigma_core.^2./6);
   
    normalizer = normalizer + psd(i) * v_core^2;
   
    intst = intst + psd(i) .*  (v_core .* obj.phi(q,r,sigma_core)).^2;
    
end

i_mod = a .* intst./normalizer;


end

