function f = f_hard_sphere(qr)
%P_HARD_SPHERE Scattering amplitude of a hard sphere
%   
%   p = p_hard_sphere(q,r)
%
%   Parameters
%   q           Scattering vector magnitudes where f is evaluated
%   r           Radius of the hard sphere
%
%   Returns
%   p           Scattering amplitude of the sphere at points q
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

f = (3.* (sin(qr) - qr.*cos(qr))./ (qr).^3);

end

