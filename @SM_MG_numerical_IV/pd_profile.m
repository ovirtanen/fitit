function [rprf, prf, w] = pd_profile(nc,rinc,rhard,sthck,vcore,vskin,fuzz)
%PD_PROFILE Calculates the radial polarization density profile for a
%microgel with a skin. We like skin. Do you like skin? Skin skin skin.
%
% [rprf, prf, w] = pd_profile(nc,rhard,rfrac,vcore,vexc,sigma)
%
% Parameters 
%
% nc        number of integration points
% rhard     hard radius without convolution
% sthick    shell thickness as a percentage of the overall radius
% rfrac     fraction of rhard when the ramp begins, e.g. 0.5
% vskin     relative polarization density at the top of the ramp
% fuzz      fuzziness factor, std of the gaussian
%
% Returns
%
% rprf      radial integration points 
% prf       refractive index density at the collocation points
% w         quadrature weight
%
% PROBLEMS
%
% If the number of integration points is small and the gaussian becomes very
% narrow its area starts to shrink, i.e. A ~= 1, because of insufficient
% resolution.
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

rng = rhard+2.*fuzz;                % range of values

w = rng ./ nc;                      % quadrature weight rng - (-rng) / nc
rprf = -rng + w .* ((1:2*nc)-0.5)';   % equidistant grid points

f = SM_MG_numerical_IV.trg6(rprf,rinc./100,rhard,sthck,vcore,vskin); % vcore is the deacay rate; rbox is unused
g = sqrt(2)./(fuzz.*sqrt(pi)).*exp(-2.*rprf.^2./(fuzz.^2));      % Pedersen's gaussian, A = 1

prf = conv2(f,g.*w,'same');            % vector convolution, add weight. Conv2 slightly faster than conv

fil = rprf > 0;

rprf = rprf(fil);
prf = prf(fil);

end