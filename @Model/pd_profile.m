function [rc, alpha] = pd_profile(nc,rhard,tau,vskin,fuzz)
%PD_PROFILE Calculates the radial polarization density profile for a
%microgel with a skin. We like skin. Do you like skin? Skin skin skin.
%
% [rc, a] = pd_profile(nc,rhard,rfrac,vcore,vexc,sigma)
%
% Parameters 
%
% nc        number of collocation points
% rhard     hard radius without convolution
% rfrac     fraction of rhard when the ramp begins, e.g. 0.5
% vcore     relative polarization density of the core
% vskin     relative polarization density at the top of the ramp
% fuzz      fuzziness factor, std of the gaussian
%
% Returns
%
% rc        radial collocation points 
% alpha     refractive index density at the collocation points
%
% PROBLEMS
%
% If the number of collocation points is small and the gaussian becomes very
% narrow its area starts to shrink, i.e. A ~= 1, because of insufficient
% resolution.
%

rng = rhard+2.*fuzz;                % range of values

w = rng ./ nc;                      % quadrature weight rng - (-rng) / nc
rc = -rng + w .* ((1:2*nc)-0.5)';   % equidistant grid points

%f = b(r,rbox,vfrac);
%f = trg(r,rbox,vi,vf);
%f = b_step(r,rbox-rbox.*0.6,rbox,vfrac,0.8.*vfrac);

f = Model.trg4(rc,tau,rhard,vskin); % vcore is the deacay rate; rbox is unused
g = sqrt(2)./(fuzz.*sqrt(pi)).*exp(-2.*rc.^2./(fuzz.^2));      % Pedersen's gaussian, A = 1

alpha = conv2(f,g.*w,'same');            % vector convolution, add weight. Conv2 slightly faster than conv

fil = rc > 0;

rc = rc(fil);
alpha = alpha(fil);

end