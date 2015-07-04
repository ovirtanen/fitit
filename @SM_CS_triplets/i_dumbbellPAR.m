function [id,swdbl] = i_dumbbellPAR(q,rpsd,psd,w,xc,pds,pdc)
%I_DUMBBELLPAR Form factor for dumbbells comprised of two core-shell
%particles calculated with multiple workers.
%
%   [id,mwnd] = i_dumbbellPAR(q,rpsd,psd,w,xc,pds,pdc) 
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
%   swdbl            Scattering mass normalizer, note: P(q) = id./swnd
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
r1 = rpsd(:) * ones(1,numel(rpsd));
r2 = r1';

% Weight grid for the integral in 2d, psd.^2.*w.^2
% The factor two comes because only triu(psdw) is needed for the calculation
% as the other half is just duplication. However only values triu(psdw,1)
% should be doubled, and not the diagonal
psdw = 2.* psd(:) * psd(:)' .* w.^2;
d = 1:length(psdw)+1:(length(psdw)+1)*length(psdw); % diagonal indices
psdw(d) = psdw(d) ./ 2;

% logical array for upper diagonal of r1,r2 and psdw
fil = logical(triu(ones(size(r1))));

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

id = SM_MG_triplets.pdb(qg,r1g,r2g,xc,pds,pdc,psdwg);

id = sum(id);


%{

id = zeros(numel(q),1);
parfor i = 1:numel(q)
   
    id(i) = sum(SM_MG_triplets.pdb(q(i),r1,r2,xc,pds,pdc,psdw));
    
end

%}

id = id(:);

swdbl = sum((SM_MG_triplets.m3(r1,(xc.*r1),pds,pdc) + SM_MG_triplets.m3(r2,(xc.*r2),pds,pdc)) .^2 .*psdw);


end


