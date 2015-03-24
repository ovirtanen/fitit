function f = f3(q,rp,rc,pds,pdc)
%F3 Scattering amplitude for a core-shell particle
%   
%   f = f3(rp,rc,pds,pdc)
%
%   Parameters
%   rp          Radius of the particle
%   rc          Radius of the core
%   pds         Contrast of the shell (particles)
%   pdc         Contrast of the core
%
%   Returns
%   m           The normalization term
%
% 
%   F3 = 1/m3 * (pds * V(rp) *F1(q,rp) + (pdc-pds) * V(rp)*F1(q,rc))
%   m3 = pds * V(rp) + (pdc-pds) * V(rc)
%
%	Pedersen, J. S. Advances in Colloid and Interface Science 1997, 70, 171?210.
%

f = (pds .* 4.*pi./3.*rp.^3 .* (3.* (sin(q.*rp) - q.*rp.*cos(q.*rp))./ (q.*rp).^3)...
    + (pdc - pds) .* 4.*pi./3.*rc.^3 .* (3.* (sin(q.*rc) - q.*rc.*cos(q.*rc))./ (q.*rc).^3))...
    ./ (pds .* 4.*pi./3.*rp.^3 + (pdc - pds) .* 4.*pi./3.*rc.^3);

%{
f = (pds .* 4.*pi./3.*rp.^3 .* SM_Hard_sphere.f_hard_sphere(q.*rp)...
    + (pdc - pds) .* 4.*pi./3.*rc.^3 .* SM_Hard_sphere.f_hard_sphere(q.*rc))...
    ./ (pds .* 4.*pi./3.*rp.^3 + (pdc - pds) .* 4.*pi./3.*rc.^3); % .m3

%}
end

