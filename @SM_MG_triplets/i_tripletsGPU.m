function [id,mwnd] = i_tripletsGPU(q,rpsd,psd,w,xl,xc,pds,pdc)
%I_tripletsGPU Form factor for triplets comprised of three core-shell
%particles calculated with GPU.
%
%   [id,mwnd] = i_tripletsGPU(q,rpsd,psd,w,xc,pds,pdc) 
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


% transfer to GPU
q = gpuArray(q);
rpsd = gpuArray(rpsd);
psd = gpuArray(psd);


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
l = nullify(l);

% eliminate repeated units and transform to column vectors
r1 = r1(l);
r2 = r2(l);
r3 = r3(l);
psdw = psdw(l);

% Obtain mole fractions of each combination r1 r2 r3 (adds also the integral weight w.^3)
psdw = arrayfun(@weight,psdw,r1,r2,r3,w);

allc = gpuArray(zeros(1,numel(q)));

% calculate several q values at once to increase performance but avoid
% running out of memory on gpu.
ngroup = 6;
ni = ceil(numel(q) ./ ngroup);

j = 1;
%qgroup = gpuArray(zeros(ngroup,1));
for i = 1:ni
    
    if i ~= ni
        qgroup = q(j:j+ngroup-1);  
    else
        qgroup = q(j:end);
    end
    
    r1g = repmat(r1,1,numel(qgroup));
    r2g = repmat(r2,1,numel(qgroup));
    r3g = repmat(r3,1,numel(qgroup));
    psdwg = repmat(psdw,1,numel(qgroup));
    qg = repelem(qgroup(:)',numel(r1),1);
   
    allc(j:j+numel(qgroup)-1) = sum(arrayfun(@itrpl,qg,r1g,r2g,r3g,xc,xl,pds,pdc,psdwg));
    
    j = j + ngroup;
    
end

% normalization weight
mwnd = sum((arrayfun(@m3,r1(:),(xc.*r1(:)),pds,pdc) + arrayfun(@m3,r2(:),(xc.*r2(:)),pds,pdc) + arrayfun(@m3,r3(:),(xc.*r3(:)),pds,pdc)) .^2 .*psdw(:));

mwnd = gather(mwnd);
id = gather(allc(:));


end

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



m3r1 = m3(r1,xc.*r1,pds,pdc);
m3r2 = m3(r2,xc.*r2,pds,pdc);
m3r3 = m3(r3,xc.*r3,pds,pdc);


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

function w = m3(rp,rc,pds,pdc)

w = pds .* 4.*pi./3.*rp.^3 + (pdc - pds) .* 4.*pi./3.*rc.^3;

end

function a = nullify(a)
%NULLIFY Sets repeated permutations in array cube r1 x r2 x r3 to 0.
% Each point in the cube represents one combination for a triplet, e.g.
% three particles with radii 1, 2 and 3. The cube has however permutations
% of these combinations, e.g. 2, 1 and 3, which are unnecessary because
% this is accounted for by weighting (see function weight) and therefore
% only increase the number of calculations that have to be performed. Only
% one permutation will be preserved, others set to 0, so that they can be
% removed.
%
%

[~,~,z] = size(a);

for i = 2:z
   
    a(:,i-1,i:end) = 0;
    
end % for

end % nullify

function p = weight(p,r1,r2,r3,w)
%WEIGHT Weights the psd according to the probabilities of obtaining certain
%combination and adds the integration weight.
%
% P(r1,r2,r3) = 6 * x1 * x2 * x3 ; r1 != r2 != r3
% P(r1,r1,r3) = 3 * x1^2 * x3
% P(r1,r1,r1) = x1^3

if r1 == r2 == r3       % all particles in triplet have the same size
    
    p = p .* w.^3;
    
elseif r1 == r2         % two particles in triplet have the same size
    
    p = 3 * p .* w.^3;
    
elseif r2 == r3         % two particles in triplet have the same size
    
    p = 3 * p .* w.^3;
    
else                    % all particles in triplet have different size
    
    p = 6 * p .* w.^3;
    
end % if

end % weight


