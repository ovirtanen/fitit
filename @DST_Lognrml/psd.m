function [rpsd,psd,w] = psd(nc,p)
%PSD Returns Lognormal PSD and collocation points
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

s = sqrt((exp(b.^2)-1).*exp(2.*a+b.^2)); % std of the distribution

% integration limits 4 stds from the mean
lowlimit = max([0 (exp(a) - 4.* s)]);
highlimit =  exp(a) + 7.* s;

%lowlimit = 0;
%highlimit = 1000;

w = (highlimit-lowlimit) ./ nc;                 % quadrature weight
rpsd = lowlimit + w .* ((1:nc)-0.5)';           % equidistant grid points for psd

%psd = lognpdf(rpsd,log(mean),log(sigma));

psd = 1./(b .* rpsd .* sqrt(2.*pi)) .* exp(-0.5 .* ((log(rpsd)-a)./b).^2);

end

