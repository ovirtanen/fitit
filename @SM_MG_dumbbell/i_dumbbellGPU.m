function id = i_dumbbellGPU(q,rpsd,psd,w,xc,pds,pdc)
%I_DUMBBELLGPU Summary of this function goes here
%   Detailed explanation goes here

r1 = gpuArray(rpsd(:)) * ones(1,numel(rpsd));
r2 = r1';

psdw = gpuArray(psd(:)) * psd(:)' .* w.^2; 

r1g = repmat(r1,[1 1 numel(q)]);
r2g = repmat(r2,[1 1 numel(q)]);
psdwg = repmat(psdw,[1 1 numel(q)]);
qg = reshape(kron(gpuArray(q(:)'),ones(size(r1))),length(r1),length(r1),length(q));

allc = arrayfun(@pdb,qg,r1g,r2g,xc,pds,pdc) .* psdwg;
allc = sum(sum(allc,1),2);

id = gather(allc(:));

end

function p = pdb(q,r1,r2,xc,pds,pdc)

m3r1 = pds .* 4.*pi./3.*r1.^3 + (pdc - pds) .* 4.*pi./3.*(xc.*r1).^3;
m3r2 = pds .* 4.*pi./3.*r2.^3 + (pdc - pds) .* 4.*pi./3.*(xc.*r2).^3;

f3r1 = (pds .* 4.*pi./3.*r1.^3 .* (3.* (sin(q.*r1) - q.*r1.*cos(q.*r1))./ (q.*r1).^3)...
        + (pdc - pds) .* 4.*pi./3.*(xc.*r1).^3 .* (3.* (sin(q.*(xc.*r1)) - q.*(xc.*r1).*cos(q.*(xc.*r1)))./ (q.*(xc.*r1)).^3))...
        ./ (pds .* 4.*pi./3.*r1.^3 + (pdc - pds) .* 4.*pi./3.*(xc.*r1).^3);

f3r2 = (pds .* 4.*pi./3.*r2.^3 .* (3.* (sin(q.*r2) - q.*r2.*cos(q.*r2))./ (q.*r2).^3)...
        + (pdc - pds) .* 4.*pi./3.*(xc.*r2).^3 .* (3.* (sin(q.*(xc.*r2)) - q.*(xc.*r2).*cos(q.*(xc.*r2)))./ (q.*(xc.*r2)).^3))...
        ./ (pds .* 4.*pi./3.*r2.^3 + (pdc - pds) .* 4.*pi./3.*(xc.*r2).^3);
    
p = (m3r1.^2 .* f3r1 .^2 + m3r2.^2 .* f3r2.^2 ...
    + 2.* m3r1 .* m3r2 .* f3r1 .* f3r2 .* sin(q.*(r1+r2))./ (q.*(r1+r2))) ...
    ./ (m3r1 + m3r2).^2;

end