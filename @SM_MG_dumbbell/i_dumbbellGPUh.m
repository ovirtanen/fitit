function [id,mwnd] = i_dumbbellGPUh(q,rpsd,psd,w,xc,pds,pdc)
%I_DUMBBELLGPUh Form factor for dumbbells comprised of two core-shell
%particles calculated with GPU.
%
%   [id,mwnd] = i_dumbbellGPUh(q,rpsd,psd,w,xc,pds,pdc) 
%
%   Parameters
%   q               Scattering vector magnitude
%   rpsd            Collocation points for core-shell particle PSD
%   psd             Particle size distribution for core-shell particles
%   xc              Fractional radius of the core, rcore = xc * rparticle
%   pds             contrast of the shell of particles
%   pdc             contrast of the cores of the particles
%
%   Returns
%   id              Scattered intensity from dumbbells
%   mwnd            Scattering mass normalizer, note: P(q) = id./swnd
%
%   Pedersen, J. S. Advances in Colloid and Interface Science 1997, 70, 171-210.

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

% Form grids for both sub units of the dumbbell
% r1 =[r1 r1 r1 ... r1          r2 =[r1 r2 r3 ... rn
%      r2 r2 r2 ... r2               r1 r2 r3 ... rn
%       . .  .      .                .  .  .      .
%      rn rn rn ... rn]              r1 r2 r3 ... rn]
%
% Dumbbell:
% r1 - r2
%
r1 = gpuArray(rpsd(:)) * ones(1,numel(rpsd));
r2 = r1';

% Weight grid for the integral in 2d, psd.^2.*w.^2
% The factor two comes because only triu(psdw) is needed for the calculation
% as the other half is just duplication. However only values triu(psdw,1)
% should be doubled, and not the diagonal
psdw = 2.* gpuArray(psd(:)) * psd(:)' .* w.^2;
d = 1:length(psdw)+1:(length(psdw)+1)*length(psdw); % diagonal indices
psdw(d) = psdw(d) ./ 2;

% logical array for upper diagonal of r1,r2 and psdw
fil = gpuArray(logical(triu(ones(size(r1)))));

% column vectors
r1 = r1(fil);
r2 = r2(fil);
psdw = psdw(fil);

% expand arrays for each q entry
r1g = repmat(r1,1,numel(q));
r2g = repmat(r2,1,numel(q));
psdwg = repmat(psdw,1,numel(q));
qg = repelem(q(:)',numel(r1),1);

% qg = [q1 q2 q3 ... qn
%       q1 q2 q3 ... qn
%       .  .  .      .
%       q1 q2 q3 ... qn]
%
% size(qg) = [length(rq1g), length(qg)]

% calculate the value of the form factor for each parameter combination
% weighted by the psd

allc = arrayfun(@pdb,qg,r1g,r2g,xc,pds,pdc,psdwg);

allc = sum(allc);

mwnd = sum((arrayfun(@m3,r1,(xc.*r1),pds,pdc) + arrayfun(@m3,r2,(xc.*r2),pds,pdc)) .^2 .*psdw);

mwnd = gather(mwnd);
id = gather(allc(:));

end

function p = pdb(q,r1,r2,xc,pds,pdc,psdwg)
% Pedersen, J. S. Advances in Colloid and Interface Science 1997, 70, 171-210.
% See M_3 and F_3 in the article. This function returns P4(q).*M4.^2


m3r1 = m3(r1,xc.*r1,pds,pdc);
m3r2 = m3(r2,xc.*r2,pds,pdc);


f3r1 = (pds .* 4.*pi./3.*r1.^3 .* (3.* (sin(q.*r1) - q.*r1.*cos(q.*r1))./ (q.*r1).^3)...
        + (pdc - pds) .* 4.*pi./3.*(xc.*r1).^3 .* (3.* (sin(q.*(xc.*r1)) - q.*(xc.*r1).*cos(q.*(xc.*r1)))./ (q.*(xc.*r1)).^3))...
        ./ m3r1;

f3r2 = (pds .* 4.*pi./3.*r2.^3 .* (3.* (sin(q.*r2) - q.*r2.*cos(q.*r2))./ (q.*r2).^3)...
        + (pdc - pds) .* 4.*pi./3.*(xc.*r2).^3 .* (3.* (sin(q.*(xc.*r2)) - q.*(xc.*r2).*cos(q.*(xc.*r2)))./ (q.*(xc.*r2)).^3))...
        ./ m3r2;
    
p = ((m3r1.^2 .* f3r1 .^2 + m3r2.^2 .* f3r2.^2 ...
    + 2.* m3r1 .* m3r2 .* f3r1 .* f3r2 .* sin(q.*(r1+r2))./ (q.*(r1+r2)))) .* psdwg;% ...
    %./ (m3r1 + m3r2).^2).*psdwg;

end

function w = m3(rp,rc,pds,pdc)

w = pds .* 4.*pi./3.*rp.^3 + (pdc - pds) .* 4.*pi./3.*rc.^3;

end