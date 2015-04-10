function id = i_dumbbell(q,rpsd,psd,w,xc,pds,pdc)
%I_DUMBBELLGPU Form factor for dumbbells comprised of two core-shell
%particles calculated with GPU. Performance 12x my previous CPU
%implementation.
%
%   id = i_dumbbellGPU(q,rpsd,psd,w,xc,pds,pdc) 
%
%   Parameters
%   q               Scattering vector magnitude
%   rpsd            Collocation points for core-shell particle PSD
%   psd             Particle size distribution for core-shell particles
%   xc              Fractional radius of the core, rcore = xc * rparticle
%   pds             contrast of the shell of particles
%   pdc             contrast of the cores of the particles
%
%
%
%   Pedersen, J. S. Advances in Colloid and Interface Science 1997, 70, 171-210.

% Form grids for both sub units of the dumbbell
% r1 =[r1 r1 r1 ... r1          r2 =[r1 r2 r3 ... rn
%      r2 r2 r2 ... r2               r1 r2 r3 ... rn
%       . .  .      .                .  .  .      .
%      rn rn rn ... rn]              r1 r2 r3 ... rn]
%
% Dumbbell:
% r1 - r2
%
r1 = (rpsd(:)) * ones(1,numel(rpsd));
r2 = r1';

% Weight grid for the integral in 2d, psd.^2.*w.^2
psdw = (psd(:)) * psd(:)' .* w.^2; 

% Expand to 3D so that each entry in the 3rd dimension corresponds to one
% q value
l= size(r1);
r1 = repmat(r1,[1 1 numel(q)]);
r2 = repmat(r2,[1 1 numel(q)]);
psdwg = repmat(psdw,[1 1 numel(q)]);

% q cube, each grid has only one q value
% q(:,:,1) =  [q1 q1 q1 ... q1
%              q1 q1 q1 ... q1
%               . .  .      .  
%              q1 q1 q1 ... q1]
q = reshape(kron(q(:)',ones(l)),max(l),max(l),length(q));

% calculate the value of the form factor for each parameter combination
% weighted by the psd

%{
m3r1 = pds .* 4.*pi./3.*r1.^3 + (pdc - pds) .* 4.*pi./3.*(xc.*r1).^3;
m3r2 = pds .* 4.*pi./3.*r2.^3 + (pdc - pds) .* 4.*pi./3.*(xc.*r2).^3;

f3r1 = (pds .* 4.*pi./3.*r1.^3 .* (3.* (sin(q.*r1) - q.*r1.*cos(q.*r1))./ (q.*r1).^3)...
        + (pdc - pds) .* 4.*pi./3.*(xc.*r1).^3 .* (3.* (sin(q.*(xc.*r1)) - q.*(xc.*r1).*cos(q.*(xc.*r1)))./ (q.*(xc.*r1)).^3))...
        ./ (pds .* 4.*pi./3.*r1.^3 + (pdc - pds) .* 4.*pi./3.*(xc.*r1).^3);

f3r2 = (pds .* 4.*pi./3.*r2.^3 .* (3.* (sin(q.*r2) - q.*r2.*cos(q.*r2))./ (q.*r2).^3)...
        + (pdc - pds) .* 4.*pi./3.*(xc.*r2).^3 .* (3.* (sin(q.*(xc.*r2)) - q.*(xc.*r2).*cos(q.*(xc.*r2)))./ (q.*(xc.*r2)).^3))...
        ./ (pds .* 4.*pi./3.*r2.^3 + (pdc - pds) .* 4.*pi./3.*(xc.*r2).^3);
    
p = ((m3r1.^2 .* f3r1 .^2 + m3r2.^2 .* f3r2.^2 ...
    + 2.* m3r1 .* m3r2 .* f3r1 .* f3r2 .* sin(q.*(r1+r2))./ (q.*(r1+r2))) ...
    ./ (m3r1 + m3r2).^2).*psdwg;
%}

p = pdb(q,r1,r2,xc,pds,pdc,psdwg);

% sum up to obtain values for each q
p = sum(sum(p,1),2);

id = p(:);

end

function p = pdb(q,r1,r2,xc,pds,pdc,psdwg)
% Pedersen, J. S. Advances in Colloid and Interface Science 1997, 70, 171-210.
% See M_3 and F_3 in the article.
%

m3r1 = pds .* 4.*pi./3.*r1.^3 + (pdc - pds) .* 4.*pi./3.*(xc.*r1).^3;
m3r2 = pds .* 4.*pi./3.*r2.^3 + (pdc - pds) .* 4.*pi./3.*(xc.*r2).^3;

f3r1 = (pds .* 4.*pi./3.*r1.^3 .* (3.* (sin(q.*r1) - q.*r1.*cos(q.*r1))./ (q.*r1).^3)...
        + (pdc - pds) .* 4.*pi./3.*(xc.*r1).^3 .* (3.* (sin(q.*(xc.*r1)) - q.*(xc.*r1).*cos(q.*(xc.*r1)))./ (q.*(xc.*r1)).^3))...
        ./ (pds .* 4.*pi./3.*r1.^3 + (pdc - pds) .* 4.*pi./3.*(xc.*r1).^3);

f3r2 = (pds .* 4.*pi./3.*r2.^3 .* (3.* (sin(q.*r2) - q.*r2.*cos(q.*r2))./ (q.*r2).^3)...
        + (pdc - pds) .* 4.*pi./3.*(xc.*r2).^3 .* (3.* (sin(q.*(xc.*r2)) - q.*(xc.*r2).*cos(q.*(xc.*r2)))./ (q.*(xc.*r2)).^3))...
        ./ (pds .* 4.*pi./3.*r2.^3 + (pdc - pds) .* 4.*pi./3.*(xc.*r2).^3);
    
p = ((m3r1.^2 .* f3r1 .^2 + m3r2.^2 .* f3r2.^2 ...
    + 2.* m3r1 .* m3r2 .* f3r1 .* f3r2 .* sin(q.*(r1+r2))./ (q.*(r1+r2))) ...
    ./ (m3r1 + m3r2).^2).*psdwg;

end