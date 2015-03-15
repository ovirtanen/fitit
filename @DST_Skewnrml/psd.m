function [rpsd,psd,w] = psd(nc,p)
%PSD Returns Gaussian PSD and collocation points
%   
%   [rpsd,p,w] = psd(nc,p)
%
%   Parameters
%   nc          Number of collocation points for the distribution
%   p           Parameter vector, where
%                   p(1)    location of the distribution (nm)
%                   p(2)    width of the distribution
%                   p(3)    skewness of the distribution
%
%   Returns
%   rpsd        Collocation points
%   psd         Value of the PSD at rpsd
%   w           Quadrature weight for midpoint rule




loc = p(1);
wdth = p(2);
skwns = p(3);

% integration limits 4 stds from the mean
lowlimit = max([0 (loc - 4.* wdth)]);
highlimit =  loc + 4.* wdth;

w = (highlimit-lowlimit) ./ nc;                 % quadrature weight
rpsd = lowlimit + w .* ((1:nc)-0.5)';           % equidistant grid points for psd

psd = 1 ./ wdth .* sqrt(2./pi) .* exp(-(rpsd-loc).^2 ./ (2.*wdth.^2)) .* 0.5 .* (1 + erf(skwns.*(rpsd - loc) ./ (sqrt(2) .* wdth)));

end

