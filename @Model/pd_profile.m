function [rc, a] = pd_profile(nc,rhard,rfrac,vcore,vexc,fuzz)
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
% vexc      excess relative polarization density at the top of the ramp, e.g. 1.1
% fuzz      fuzziness factor, std of the gaussian
%
% Returns
%
% rc        radial collocation points 
% a         refractive index density at the collocation points

rng = rhard+2.*fuzz;               % range of values
rc = linspace(-(rng),rng,2.*nc)';
             
w = mean(diff(rc));                 % quadrature weight, average rounding errors

%f = b(r,rbox,vfrac);
%f = trg(r,rbox,vi,vf);
%f = b_step(r,rbox-rbox.*0.6,rbox,vfrac,0.8.*vfrac);

rbox = rhard .* rfrac;
vmax = vcore .* vexc;

f = Model.trg2(rc,rbox,rhard,vcore,vmax);
g = sqrt(2)./(fuzz.*sqrt(pi)).*exp(-2.*rc.^2./(fuzz.^2));      % Pedersen's gaussian, A = 1

a = conv(f,g.*w,'same');            % vector convolution, add weight

fil = rc > 0;

rc = rc(fil);
a = a(fil);

end

