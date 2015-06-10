function [rpsd,psd,w] = psd(nc,p)
%PSD Returns Gaussian PSD and collocation points
%   
%   [rpsd,p,w] = psd(nc,p)
%
%   Parameters
%   nc          Number of collocation points for the distribution
%   p           Parameter vector, where
%                   p(1)    mean of the distribution (nm)
%                   p(2)    std of the distribution (nm)
%
%   Returns
%   rpsd        Collocation points
%   psd         Value of the PSD at rpsd
%   w           Quadrature weight for midpoint rule

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.


a = p(1);
b = p(2);
std = sqrt((pi.*b).^2./2);

% integration limits 4 stds from the mean
lowlimit = max([0 (a - 4.* std)]);
highlimit =  a + 4.* std;

w = (highlimit-lowlimit) ./ nc;                 % quadrature weight
rpsd = lowlimit + w .* ((1:nc)-0.5)';           % equidistant grid points for psd

psd = 1./b .* exp((a-rpsd)./b).*exp(-exp((a-rpsd)./b));

end

