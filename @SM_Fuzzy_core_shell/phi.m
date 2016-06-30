function r = phi(q,R,sigma)
%PHI Normalized Fourier transform of fuzzy core shell profile
%
%
% Parameters
%   q       Scattering vector magnitudes
%   R       Particle radius at half width of the fuzzy periphery
%   sigma   Half width of the fuzzy periphery

% Copyright (c) Otto Virtanen and Arjan Gelissen 2016
% All rights reserved.


Vn = ((R.^3)/3)+((R.*sigma.^2)./6);


a = (R./sigma.^2) + 1./sigma;
b = (R./sigma.^2) - 1./sigma;
c = R + sigma;
d = R - sigma;
f = (q.^5) .* (sigma.^2);
g = (q.^4) .* (sigma.^2);

r = 1./Vn .* ((a.*cos(q.*c)./(q.^4)) + (b.*cos(q.*d)./(q.^4)) - (3.*sin(q.*c)./f) - (3.*sin(q.*d)./f) - (2.*R.*cos(q.*R)./g) + (6.*sin(q.*R)./f));


end

