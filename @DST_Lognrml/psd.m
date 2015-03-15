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




mean = p(1);
sigma = p(2);

s = sqrt((exp(log(sigma).^2)-1).*exp(2.*log(mean)+log(sigma).^2)); % std of the distribution

% integration limits 4 stds from the mean
lowlimit = max([0 (mean - 4.* s)]);
highlimit =  mean + 7.* s;

w = (highlimit-lowlimit) ./ nc;                 % quadrature weight
rpsd = lowlimit + w .* ((1:nc)-0.5)';           % equidistant grid points for psd

psd = lognpdf(rpsd,log(mean),log(sigma));

end

