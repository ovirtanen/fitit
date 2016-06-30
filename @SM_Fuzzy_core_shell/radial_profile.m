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
r_tot = obj.dist.mean();
r_box_frac = obj.get_param('r_box_val');
sigma_core_frac = obj.get_param('sigma_core_val');
ws_frac = obj.get_param('ws_val'); % shell width

vfc = obj.get_param('vfc_val');     % "volume fraction" core
vfs = obj.get_param('vfs_val');     % "volume fraction" shell

% Calculate absolute values
r_box = r_box_frac * r_tot;
sigma_core = sigma_core_frac * (r_tot-r_box)/2;
ws = ws_frac .* (r_tot - r_box - 2.*sigma_core);
sigma_shell = (r_tot - (r_box + ws + 2.*sigma_core))/2;

rprf = linspace(0,1.01.*r_tot,100);

% Create filters for the pairwise defined function
f_core = rprf <= r_box;
f_fuzzy_core_in = rprf > r_box & rprf <= r_box + sigma_core;
f_fuzzy_core_out = rprf > r_box + sigma_core & rprf <= r_box + 2* sigma_core;
f_fuzzy_core_zero = rprf > r_box + 2* sigma_core;

r_box_shell = r_box + 2* sigma_core + ws;
f_shell = rprf <= r_box_shell;
f_fuzzy_shell_in = rprf > r_box_shell & rprf <= r_box_shell + sigma_shell;
f_fuzzy_shell_out = rprf > r_box_shell + sigma_shell & rprf <= r_box_shell + 2* sigma_shell;
f_fuzzy_shell_zero = rprf > r_tot;

% Calculate profile of the core particle
prf_c = zeros(size(rprf));
prf_c(f_core) = 1;
prf_c(f_fuzzy_core_in) = 1 - 0.5.*((rprf(f_fuzzy_core_in)-(r_box + sigma_core)) + sigma_core).^2./sigma_core.^2;
prf_c(f_fuzzy_core_out) = 0.5.*(((r_box + sigma_core) - rprf(f_fuzzy_core_out)) + sigma_core).^2./sigma_core.^2;
prf_c(f_fuzzy_core_zero) = 0;


% Calculate profile of the shell partiicle
prf_s = zeros(size(rprf));
prf_s(f_shell) = 1;
prf_s(f_fuzzy_shell_in) = 1 - 0.5.*((rprf(f_fuzzy_shell_in) - (r_box_shell + sigma_shell)) + sigma_shell).^2./sigma_shell.^2;
prf_s(f_fuzzy_shell_out) = 0.5.*(((r_box_shell + sigma_shell) - rprf(f_fuzzy_shell_out)) + sigma_shell).^2./sigma_shell.^2;
prf_s(f_fuzzy_shell_zero) = 0;

% Return overall profile
prf = vfs .* prf_s + (vfc - vfs) .* prf_c;

end

