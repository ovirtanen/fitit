function [rprf,prf] = radial_profile(obj)
%RADIAL_PROFILE Radial profile of a fuzzy core shell particle for the mean particle
%radius
%   
%   [rprf,prf] = radial_profile()
%
%   Returns
%   rprf        Radial points from the center of the particle
%   prf         Radial profile    
%
%

% Copyright (c) Otto Virtanen and Arjan Gelissen 2016
% All rights reserved.

% Collect parameters
R_tot = obj.dist.mean();
Rbox_frac = obj.get_param('Rbox_val');
sigmaC_frac = obj.get_param('sigmaC_val');
RS_frac = obj.get_param('RS_val');

volfracC = obj.get_param('volfracC_val');
volfracS = obj.get_param('volfracS_val');

% Calculate absolute values
Rbox = Rbox_frac * R_tot;
sigmaC = sigmaC_frac * (R_tot-Rbox)/2;
RS = RS_frac .* (R_tot - Rbox - 2.*sigmaC);
sigmaS = (R_tot - (Rbox + RS + 2.*sigmaC))/2;

rprf = linspace(0,R_tot,100);

% Create filters for the pairwise function
f_core = rprf <= Rbox;
f_fuzzy_core_in = rprf > Rbox & rprf <= Rbox + sigmaC;
f_fuzzy_core_out = rprf > Rbox + sigmaC & rprf <= Rbox + 2* sigmaC;

Rbox_shell = Rbox + 2* sigmaC + RS;
f_shell = rprf <= Rbox_shell;
f_fuzzy_shell_in = rprf > Rbox_shell & rprf <= Rbox_shell + sigmaS;
f_fuzzy_shell_out = rprf > Rbox_shell + sigmaS & rprf <= Rbox_shell + 2* sigmaS;

% Calculate profile of the core particle
prf_c = zeros(size(rprf));
prf_c(f_core) = 1;
prf_c(f_fuzzy_core_in) = 1 - 0.5.*((rprf(f_fuzzy_core_in)-(Rbox + sigmaC)) + sigmaC).^2./sigmaC.^2;
prf_c(f_fuzzy_core_out) = 0.5.*(((Rbox + sigmaC) - rprf(f_fuzzy_core_out)) + sigmaC).^2./sigmaC.^2;

% Calculate profile of the shell partiicle
prf_s = zeros(size(rprf));
prf_s(f_shell) = 1;
prf_s(f_fuzzy_shell_in) = 1 - 0.5.*((rprf(f_fuzzy_shell_in) - (Rbox_shell + sigmaS)) + sigmaS).^2./sigmaS.^2;
prf_s(f_fuzzy_shell_out) = 0.5.*(((Rbox_shell + sigmaS) - rprf(f_fuzzy_shell_out)) + sigmaS).^2./sigmaS.^2;

% Return overall profile
prf = volfracS .* prf_s + (volfracC - volfracS) .* prf_c;

end

