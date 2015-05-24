function v = V(r,dr)
%V Scattering mass of a hollow microgel particle
%   v = V(r,dr)
%
% Parameters
% r             Outer radius of the particle
% dr            Decay rate of the profile

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

v = 4.*pi .*(r.^2./dr - 2.*r./dr.^2 + 2.*(1-exp(-dr.*r))./dr.^3);

end

