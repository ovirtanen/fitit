function p = itrpl(q,r1,r2,r3,xc,xl,pds,pdc,psdw)
% Pedersen, J. S. Advances in Colloid and Interface Science 1997, 70, 171-210.
% See M_3 and F_3 in the article. This function returns P4(q).*M4.^2
%
%   Parameters
%   q           Scattering vector magnitude
%   r1          Array for first particle radii
%   r2          Array for second particle radii
%   r3          Array for third particle radii
%   xc          Fractional radius of the core in the core-shell particles
%   xl          Fraction of linear triplets
%   pds         Polarization density of the core
%   pdc         Polarization density of the shell
%   psdw        Total mole fraction of particles consisting of r1 r2 and r3



m3r1 = SM_MG_triplets.m3(r1,xc.*r1,pds,pdc);
m3r2 = SM_MG_triplets.m3(r2,xc.*r2,pds,pdc);
m3r3 = SM_MG_triplets.m3(r3,xc.*r3,pds,pdc);


f3r1 = (pds .* 4.*pi./3.*r1.^3 .* (3.* (sin(q.*r1) - q.*r1.*cos(q.*r1))./ (q.*r1).^3)...
        + (pdc - pds) .* 4.*pi./3.*(xc.*r1).^3 .* (3.* (sin(q.*(xc.*r1)) - q.*(xc.*r1).*cos(q.*(xc.*r1)))./ (q.*(xc.*r1)).^3))...
        ./ m3r1;

f3r2 = (pds .* 4.*pi./3.*r2.^3 .* (3.* (sin(q.*r2) - q.*r2.*cos(q.*r2))./ (q.*r2).^3)...
        + (pdc - pds) .* 4.*pi./3.*(xc.*r2).^3 .* (3.* (sin(q.*(xc.*r2)) - q.*(xc.*r2).*cos(q.*(xc.*r2)))./ (q.*(xc.*r2)).^3))...
        ./ m3r2;
    
f3r3 = (pds .* 4.*pi./3.*r3.^3 .* (3.* (sin(q.*r3) - q.*r3.*cos(q.*r3))./ (q.*r3).^3)...
        + (pdc - pds) .* 4.*pi./3.*(xc.*r3).^3 .* (3.* (sin(q.*(xc.*r3)) - q.*(xc.*r3).*cos(q.*(xc.*r3)))./ (q.*(xc.*r3)).^3))...
        ./ m3r3;    

p = ((m3r1 .* f3r1).^2 + (m3r2.*f3r2).^2 + (m3r3.*f3r3).^2 ...
    + 2.* m3r1.*m3r2.*f3r1.*f3r2 .* ((1-xl).* sin(q.*(r1+r2)) ./ (q.*(r1+r2)) + xl.*2.*sin(q.*(r1+r2)) ./ (3.*q.*(r1+r2)) + xl.*sin(q.*(r1+r3)) ./ (3.*q.*(r1+r3))) ...
    + 2.* m3r2.*m3r3.*f3r2.*f3r3 .* ((1-xl).* sin(q.*(r2+r3)) ./ (q.*(r2+r3)) + xl.*2.*sin(q.*(r2+r3)) ./ (3.*q.*(r2+r3)) + xl.*sin(q.*(r1+r3)) ./ (3.*q.*(r1+r3))) ...
    + 2.* m3r1.*m3r3.*f3r1.*f3r3 .* ((1-xl).* sin(q.*(r1+r3)) ./ (q.*(r1+r3)) + xl.*sin(q.*(r1+2.*r2+r3)) ./ (3.*q.*(r1+2.*r2+r3)) + xl.*sin(q.*(r1+2.*r3+r2)) ./ (3.*q.*(r1+2.*r3+r2)) + xl.*sin(q.*(r2+2.*r1+r3)) ./ (3.*q.*(r2+2.*r1+r3)))) .* psdw;
    

end
