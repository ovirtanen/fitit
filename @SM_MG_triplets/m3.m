function w = m3(rp,rc,pds,pdc)

w = pds .* 4.*pi./3.*rp.^3 + (pdc - pds) .* 4.*pi./3.*rc.^3;

end
