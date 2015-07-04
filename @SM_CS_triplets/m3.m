function w = m3(rp,rc,pds,pdc)

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

w = pds .* 4.*pi./3.*rp.^3 + (pdc - pds) .* 4.*pi./3.*rc.^3;

end
