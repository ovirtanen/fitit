function p = pdb(q,r1,r2,xc,pds,pdc,psdwg)
% Pedersen, J. S. Advances in Colloid and Interface Science 1997, 70, 171-210.
% See M_3 and F_3 in the article. This function returns P4(q).*M4.^2

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

m3r1 = SM_MG_triplets.m3(r1,xc.*r1,pds,pdc);
m3r2 = SM_MG_triplets.m3(r2,xc.*r2,pds,pdc);


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