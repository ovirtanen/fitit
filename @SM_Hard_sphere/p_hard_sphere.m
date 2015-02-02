function p = p_hard_sphere(qr)
%P_HARD_SPHERE Form factor of a hard sphere
%   
%   p = p_hard_sphere(q,r)
%
%   Parameters
%   q           Scattering vector magnitudes where p is evaluated
%   r           Radius of the hard sphere
%
%   Returns
%   p           Form factor of the sphere at points q
%


p = (3.* (sin(qr) - qr.*cos(qr))./ (qr).^3).^2;

end

