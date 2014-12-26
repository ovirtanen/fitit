function hri = b_step(r,rcore,rp,vc,vs)
%B_STEP Step box polarization density function
% 
% hri = b_step(r,rb1,rb2,m1,m2)
%
% Parameters
% 
% r             Radial points at which density profile is evaluated
% rcore         Radius of the core
% rp            Radius of the particle
% vc            Polarization density in the core
% vs            Polarization density in the shell
%
% Returns
%
% hri           Hard polarization density at points r
%

fb1 = (abs(r) <= rcore);
fb2 = (abs(r) > rcore & abs(r) <= rp);

hri = zeros(numel(r),1);

hri(fb1) = vc;
hri(fb2) = vs;

end

