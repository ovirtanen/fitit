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




mean = p(1);
sigma = p(2);

% integration limits 4 stds from the mean
lowlimit = max([0 (mean - 4.* sigma)]);
highlimit =  mean + 4.* sigma;

w = (highlimit-lowlimit) ./ nc;                 % quadrature weight
rpsd = lowlimit + w .* ((1:nc)-0.5)';           % equidistant grid points for psd

psd = normpdf(rpsd,mean,sigma);

end

