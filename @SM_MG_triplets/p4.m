function p = p4(q,xc,r1,r2,pds,pdc)
%P4 Form factor of a dumbbell formed of two core-shell particles
%   
%   p = p4(q,xc,r1,r2,pds,pdc)
%
%   Parameters
%   q               Scattering vector magnitude
%   xc              Fractional radius of the core, rcore = xc * rparticle
%   r1              radius of the 1st particle of the dumbbell
%   r2              radius of the 2nd particle of the dumbbell
%   pds             contrast of the shell of particles
%   pdc             contrast of the cores of the particles
%
%   Either q or ri and r2 have to be scalars. Both cannot be matrices!
%   This is not checked due to performance considerations.
%
%
%   Pedersen, J. S. Advances in Colloid and Interface Science 1997, 70, 171?210.

m3r1 = SM_Core_shell.m3(r1,xc.*r1,pds,pdc);
m3r2 = SM_Core_shell.m3(r2,xc.*r2,pds,pdc);
f3r1 = SM_Core_shell.f3(q,r1,xc.*r1,pds,pdc);
f3r2 = SM_Core_shell.f3(q,r2,xc.*r2,pds,pdc);

p = (m3r1.^2 .* f3r1 .^2 + m3r2.^2 .* f3r2.^2 ...
    + 2.* m3r1 .* m3r2 .* f3r1 .* f3r2 .* sin(q.*(r1+r2))./ (q.*(r1+r2))) ...
    ./ (m3r1 + m3r2).^2;


%{
p = ((pds .* 4.*pi./3.*r1.^3 + (pdc - pds) .* 4.*pi./3.*(xc.*r1).^3).^2 .* SM_Core_shell.f3(q,r1,xc.*r1,pds,pdc).^2 ...
+   (pds .* 4.*pi./3.*r2.^3 + (pdc - pds) .* 4.*pi./3.*(xc.*r2).^3).^2 .* SM_Core_shell.f3(q,r2,xc.*r2,pds,pdc).^2 ...
+ 2.* (pds .* 4.*pi./3.*r1.^3 + (pdc - pds) .* 4.*pi./3.*(xc.*r1).^3) .* (pds .* 4.*pi./3.*r2.^3 + (pdc - pds) .* 4.*pi./3.*(xc.*r2).^3) ...
.* SM_Core_shell.f3(q,r1,xc.*r1,pds,pdc) .* SM_Core_shell.f3(q,r2,xc.*r2,pds,pdc) ...
.* sin(q.*(r1+r2))./ (q.*(r1+r2))) ...
./ ((pds .* 4.*pi./3.*r1.^3 + (pdc - pds) .* 4.*pi./3.*(xc.*r1).^3) + (pds .* 4.*pi./3.*r2.^3 + (pdc - pds) .* 4.*pi./3.*(xc.*r2).^3)).^2;
%}
%{
p = (SM_Core_shell.m3(r1,xc.*r1,pds,pdc).^2 .* SM_Core_shell.f3(q,r1,xc.*r1,pds,pdc).^2 ...
+ SM_Core_shell.m3(r2,xc.*r2,pds,pdc).^2 .* SM_Core_shell.f3(q,r2,xc.*r2,pds,pdc).^2 ...
+ 2.* SM_Core_shell.m3(r1,xc.*r1,pds,pdc) .* SM_Core_shell.m3(r2,xc.*r2,pds,pdc) ...
.* SM_Core_shell.f3(q,r1,xc.*r1,pds,pdc) .* SM_Core_shell.f3(q,r2,xc.*r2,pds,pdc) ...
.* sin(q.*(r1+r2))./ (q.*(r1+r2))) ...
./ (SM_Core_shell.m3(r1,xc.*r1,pds,pdc) + SM_Core_shell.m3(r2,xc.*r2,pds,pdc)).^2;

%}

end

