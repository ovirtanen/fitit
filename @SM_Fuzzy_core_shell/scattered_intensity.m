function i_mod = scattered_intensity(obj,nc,q,p)
%SCATTERED_INTENSITY Scattered intensity of core shell particle
%   i_mod = scattered_intensity(nc,q,p)
%
%   Parameters
%   nc          Number of collcation points for the distribution
%   q           Scattering vector magnitudes
%   p           Parameter vector p, where
%                   p(1)        Number of particles
%                   p(2)        Width of the particle chell
%                   p(3)        Width of the particle core
%                   p(4)        Width of the interpenetration region of
%                               core and shell
%                   p(5)        Relative scattering contrast *
%                               polymer volumefraction of the core
%                   p(6)        Relative scattering contrast *
%                               polymer volumefraction of the shell
%                   p(5:end)    Parameters for the PSD
%                   sigmaS      Dependent parameter: R - p(2)-p(3)-p(4)
%
%
%   Returns
%   i_mod       Scattered intensity at points q
%
%   I. Berndt, J.S. Pedersen, P. Lindner, W. Richtering, Langmuir 22 (2006) 459.
%   M. Stieger, W. Richtering, J.S. Pedersen, P. Lindner, J. Chem. Phys. 120 (2004) 6197.

% Copyright (c) Otto Virtanen and Arjan Gelissen 2016
% All rights reserved.

a = p(1);
r_box_frac = p(2);      % Radius of the box as fraction of total particle radius rpsd(i)
sigma_core_frac = p(3);
ws_frac = p(4);         % width of the shell
vfc = p(5);             % relative contrast of the core
vfs = p(6);             % relative contrast of the shell

[rpsd,psd,~] = obj.dist.psd(nc,p(7:end));
intst = zeros(size(q));
normalizer = 0;

for i = 1 : numel(rpsd)
    
    r_tot = rpsd(i);
    
    r_box = r_box_frac .* r_tot;
    sigma_core = sigma_core_frac .* (r_tot - r_box)./2;
    ws = ws_frac .* (r_tot - r_box - 2 .* sigma_core);
    sigma_shell = (r_tot - (r_box + ws + 2.*sigma_core))/2;
    
    r_out = r_tot - sigma_shell;
    r_in = r_box + sigma_core;
    
    % Volumes of core and shlee
    v_core = 4*pi*(r_in.^3/3 + r_in.*sigma_core.^2./6);
    v_shell = 4*pi*(r_out.^3/3 + r_out.*sigma_shell.^2./6);
    
    normalizer = normalizer + psd(i) * (vfs .* v_shell + (vfc - vfs) .* v_core).^2;
   
    intst = intst + psd(i) .* (vfs .* v_shell .* obj.phi(q,r_out,sigma_shell) + (vfc - vfs) .* v_core .* obj.phi(q,r_in,sigma_core)).^2;
    
end

i_mod = a .* intst./normalizer;


end

