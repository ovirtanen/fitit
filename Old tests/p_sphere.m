function p = p_sphere(r,q)
%P_SPHERE Form factor of a sphere
%   p = p_sphere( q,r ), where q is the vector containing q values and r
%   the radius of the sphere, returns form factor p at q.


p = (3.*(sin(q.*r) - q.*r.*cos(q*r)) ./ (q.*r).^3).^2;


end

