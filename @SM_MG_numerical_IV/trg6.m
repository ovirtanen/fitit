function hri = trg6(r,rinc,rp,sthck,v,vm)
%TRG5 Hard polarization density profile for a microgel with a exponential 
%ramp at the end of the constant density shell, determined by the decay rate.
%   hri = trg5(r,tau,rp,sthck,vm)
%
% Parameters
% 
% r             Radial points at which density profile is evaluated
% rinc          Radial point at which the ri density starts to increase
% rp            Radius of the particle
% shtck         Fraction of the constant density shell of the total radius
% v             Polarization density in the core
% vm            Maximum polarization density at the periphery of the particle
%
% Returns
% 
% hri           Hard polarization density at points r
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

hri = zeros(numel(r),1);

fb = abs(r) <= rinc.*rp;              % box
hri(fb) = v;                          % box pd

fr = not(fb) & abs(r) <= rp-sthck;    % exponential ramp until point rp-sthck
tau = log(vm./v)./(rp-sthck-rinc.*rp);
hri(fr) = exp(tau.*(abs(r(fr))-(rp-sthck))+log(vm));

fp = abs(r) > rp-sthck & abs(r) <= rp; % periphery
hri(fp) = vm; % pd in the box at the periphery

end

