function [rpsd,psd,w] = psd(nc,p)
%PSD Returns Gaussian PSD and integration points
%   
%   [rpsd,p,w] = psd(nc,p)
%
%   Parameters
%   nc          Number of collocation points for the distribution
%   p           Parameter vector, where
%                   p(1)    mean of the distribution (nm^3)
%                   p(2)    PDI of the distribution (%)
%
%   Returns
%   rpsd        Integration points
%   psd         Value of the PSD at rpsd
%   w           Quadrature weight for midpoint rule

% Copyright (c) 2015,2016 Otto Virtanen
% All rights reserved.


mean = p(1);
pdi = p(2)./100; % PDI given as %, go to fraction
sigma = mean.*pdi;

% integration limits 4 stds from the mean in respect to volume
lowlimit = max([0 (mean - 4.* sigma)]);
highlimit =  mean + 4.* sigma;

% convert to radius
lowlimit = nthroot(3.*lowlimit./(4.*pi),3);
highlimit = nthroot(3.*highlimit./(4.*pi),3);

% grid in terms of radius
w = (highlimit-lowlimit) ./ nc;                 % quadrature weight
rpsd = lowlimit + w .* ((1:nc)-0.5)';           % equidistant grid points for psd

psd = 4.*pi.*rpsd.^2.*normpdf(4.*pi.*rpsd.^3./3,mean,sigma);

end

