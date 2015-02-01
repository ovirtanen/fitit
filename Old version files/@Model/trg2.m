function [ hri ] = trg2(r,rinc,rp,v,vm)
%TRG2 Hard polarization density profile for a microgel with a linear ramp
%at the periphery
%   [ hri ] = trg2( r,r1,r2,v,vm)
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

fb = abs(r) <= rinc;                  % box
fr = abs(r) > rinc & abs(r) <= rp;    % ramp

hri = zeros(numel(r),1);

hri(fb) = v;
hri(fr) = (vm-v)./(rp-rinc) .* (abs(r(fr))-rinc) + v;


end

