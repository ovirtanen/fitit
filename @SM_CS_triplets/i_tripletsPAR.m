function [id,mwnd] = i_tripletsPAR(q,rpsd,psd,w,xl,xc,pds,pdc)
%I_tripletsGPU Form factor for triplets comprised of three core-shell
%particles calculated with multiple workers.
%
%   [id,mwnd] = i_tripletsPAR(q,rpsd,psd,w,xc,pds,pdc) 
%
%   Parameters
%   q               Scattering vector magnitude
%   rpsd            Collocation points for core-shell particle PSD
%   psd             Particle size distribution for core-shell particles
%   w               Integration weight
%   xl              Fraction of linear triplets
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



r1 = rpsd(:) * ones(1,numel(rpsd));
r2 = tril(r1');

r1 = repmat(r1,1,1,numel(rpsd));
r2 = repmat(r2,1,1,numel(rpsd));

r3 = reshape(repelem(rpsd,numel(rpsd),numel(rpsd)),[numel(rpsd) numel(rpsd) numel(rpsd)]);

psdw = psd(:) * psd(:)';
% 3d matrix psd x psd xpsd
psdw = repmat(psdw,1,1,numel(rpsd)) .* reshape(repelem(psd,numel(psd),numel(psd)),[numel(psd) numel(psd) numel(psd)]); 

% logical array used to extract the non repeated
l = tril(logical(ones(numel(rpsd))));
l = repmat(l,1,1,numel(rpsd));
l = SM_CS_triplets.nullify(l);

% eliminate repeated units and transform to column vectors
r1 = r1(l);
r2 = r2(l);
r3 = r3(l);
psdw = psdw(l);

% Obtain mole fractions of each combination r1 r2 r3 (adds also the integral weight w.^3)
psdw = SM_CS_triplets.weight(psdw,r1,r2,r3,w);

id = zeros(numel(q),1);
parfor i = 1:numel(q)
    
    id(i) = sum(SM_CS_triplets.itrpl(q(i),r1,r2,r3,xc,xl,pds,pdc,psdw));
    
end

% normalization weight
mwnd = sum((SM_CS_triplets.m3(r1(:),(xc.*r1(:)),pds,pdc) + SM_CS_triplets.m3(r2(:),(xc.*r2(:)),pds,pdc) + SM_CS_triplets.m3(r3(:),(xc.*r3(:)),pds,pdc)) .^2 .* psdw(:));
id = id(:);

end









