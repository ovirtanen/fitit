function m = m3(rp,rc,pds,pdc)
%M3 Normalization term for core-shell particle
%   
%   m = m3(rp,rc,pds,pdc)
%
%   Parameters
%   rp          Radius of the particle
%   rc          Radius of the core
%   pds         Contrast of the shell (particles)
%   pdc         Contrast of the core
%
%   Returns
%   m           The normalization term
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

m = pds .* 4.*pi./3.*rp.^3 + (pdc - pds) .* 4.*pi./3.*rc.^3;

end

