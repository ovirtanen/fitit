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
sigma_core_frac = obj.get_param('2sigma_val')/2;

%vfc = obj.get_param('vfc_val');     % "volume fraction" core

% Calculate absolute values
sigma_core = sigma_core_frac * r_tot;
r_box = r_tot - 2*sigma_core;

rprf = linspace(0,1.01.*r_tot,100);

% Create filters for the pairwise defined function
f_core = rprf <= r_box;
f_fuzzy_core_in = rprf > r_box & rprf <= r_box + sigma_core;
f_fuzzy_core_out = rprf > r_box + sigma_core & rprf <= r_box + 2* sigma_core;
f_fuzzy_core_zero = rprf > r_tot;

% Calculate profile of the core particle
prf = zeros(size(rprf));
prf(f_core) = 1;
prf(f_fuzzy_core_in) = 1 - 0.5.*((rprf(f_fuzzy_core_in)-(r_box + sigma_core)) + sigma_core).^2./sigma_core.^2;
prf(f_fuzzy_core_out) = 0.5.*(((r_box + sigma_core) - rprf(f_fuzzy_core_out)) + sigma_core).^2./sigma_core.^2;
prf(f_fuzzy_core_zero) = 0;


%prf = vfc .* prf;

end

