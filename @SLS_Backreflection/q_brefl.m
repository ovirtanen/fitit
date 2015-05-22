function qbr = q_brefl(obj,q)
%Q_BREFL Calculates the backreflected q for cuvette backrefection in SLS
%
%   qbr = q_brefl(q)
%
% Arguments
% q         Nominal scattering vector magnitudes
%
% Returns
% qbr       Backreflected q magnitudes for each nominal q
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

wl = obj.w_length;
ri = obj.refr_index;

a = 2.*asin(q.*wl./(4.*pi.*ri));

qbr = 4.*pi.*ri./wl.*sin((pi-a)./2);


end

