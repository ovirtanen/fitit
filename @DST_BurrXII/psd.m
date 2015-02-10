function [rpsd,psd,w] = psd(nc,p)
%PSD Returns Burr Type XII PSD and collocation points
%   
%   [rpsd,p,w] = psd(nc,p)
%
%   Parameters
%   nc          Number of collocation points for the distribution
%   p           Parameter vector, where
%                   p(1)    Burr parameter a
%                   p(2)    Burr parameter c
%                   p(3)    Burr parameter k
%
%   Returns
%   rpsd        Collocation points
%   psd         Value of the PSD at rpsd
%   w           Quadrature weight for midpoint rule




a = p(1);
c = p(2);
k = p(3);

m1 = DST_BurrXII.burr_moments(1,a,c,k);         % 1st moment = mean
m2 = DST_BurrXII.burr_moments(2,a,c,k);         % 2nd moment
std = sqrt(-m1.^2 + m2);                        % variance = -m1.^2 + m2

lowlimit = max([0 m1 - 5.* min([1 3.*k]) .* std]); % totally arbitrary limits
highlimit =  m1 + 6 .* std;

w = (highlimit-lowlimit) ./ nc;                 % quadrature weight
rpsd = lowlimit + w .* ((1:nc)-0.5)';           % equidistant grid points for psd

psd = DST_BurrXII.burrpdf(rpsd,a,c,k);

end

