function [ hri ] = trg3(r,rinc,rp,v,vm)
%TRG3 Hard polarization density profile for a microgel with a exponential ramp
%at the periphery determined by predetermined points.
%   [ hri ] = trg3( r,r1,r2,v,vm)
%
% Parameters
% 
% r             Radial points at which density profile is evaluated
% rinc          Radial point at which the ri density starts to increase
% rp            Radius of the particle
% v             Polarization density in the core
% vm            Maximum polarization density at the periphery of the particle
%
% Returns
% 
% hri           Hard polarization density at points r
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

fb = abs(r) <= rinc;                  % box
fr = not(fb) & abs(r) <= rp;          % exponential ramp

hri = zeros(numel(r),1);

hri(fb) = v;

tau = log(vm./v)./(rp-rinc);

hri(fr) = exp(tau.* abs(r(fr)-rinc)+log(v));


end

