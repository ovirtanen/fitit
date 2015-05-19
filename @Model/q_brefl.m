function qbr = q_brefl(q,n,lambda)
%Q_BREFL Calculates the backreflected q for cuvette backrefection in SLS
%
%   qbr = q_brefl(q,n,lambda)
%
% Arguments
% q         Nominal scattering vector magnitudes
% n         Refractive index of the scattering medium
% lambda    Wavelength of the laser (nm)
%
% Returns
% qbr       Backreflected q magnitudes for each nominal q
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

a = 2.*asin(q.*lambda./(4.*pi.*n));

qbr = 4.*pi.*n./lambda.*sin((pi-a)./2);

end

