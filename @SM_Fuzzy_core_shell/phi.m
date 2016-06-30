function r = phi(q,r,sigma)
%PHI Normalized Fourier transform of fuzzy core shell profile
%
%
% Parameters
%   q       Scattering vector magnitudes
%   r       Particle radius at half width of the fuzzy periphery
%   sigma   Half width of the fuzzy periphery

% Copyright (c) Otto Virtanen and Arjan Gelissen 2016
% All rights reserved.

Vn = ((r.^3)/3)+((r.*sigma.^2)./6);

r = 1./Vn .* ((r./sigma.^2 + 1./sigma) .* cos(q.*(r + sigma))./q.^4 ...
    + (r./sigma.^2 - 1./sigma).*cos(q.*(r - sigma))./q.^4 ...
    - 3.*sin(q.*(r + sigma))./(q.^5 .* sigma.^2) ...
    - 3.*sin(q.*(r - sigma))./(q.^5 .* sigma.^2) ...
    - 2.*r.*cos(q.*r)./(q.^4 .* sigma.^2) ...
    + 6.*sin(q.*r)./(q.^5 .* sigma.^2));


end

