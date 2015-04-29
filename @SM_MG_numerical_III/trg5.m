function hri = trg5(r,tau,rp,sthck,vm)
%TRG5 Hard polarization density profile for a microgel with a exponential 
%ramp at the end of the constant density shell, determined by the decay rate.
%   hri = trg5(r,tau,rp,sthck,vm)
%
% Parameters
% 
% r             Radial points at which density profile is evaluated
% tau           Decay constant for the exponential
% rp            Radius of the particle
% shtck         Fraction of the constant density shell of the total radius
% vm            Maximum polarization density at the periphery of the particle
%
% Returns
% 
% hri           Hard polarization density at points r
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

hri = zeros(numel(r),1);
hri(abs(r) <= rp) = vm;
fr = abs(r) <= rp-sthck;

hri(fr) = exp(tau.*(abs(r(fr))-(rp-sthck))+log(vm));

end

