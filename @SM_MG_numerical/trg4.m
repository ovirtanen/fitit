function hri = trg4(r,tau,rp,vm)
%TRG4 Hard polarization density profile for a microgel with a exponential 
%ramp at the periphery, determined by the decay rate.
%   hri = trg4(r,tau,rp,vm)
%
% Parameters
% 
% r             Radial points at which density profile is evaluated
% tau           Decay constant for the exponential
% rp            Radius of the particle
% vm            Maximum polarization density at the periphery of the particle
%
% Returns
% 
% hri           Hard polarization density at points r
%

hri = zeros(numel(r),1);

fr = abs(r) <= rp;

hri(fr) = exp(tau.*(abs(r(fr))-rp)+log(vm));

end

