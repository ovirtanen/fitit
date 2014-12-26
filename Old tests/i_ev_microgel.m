function [p,r,d,w]= i_ev_microgel(param,q)
%I_microgel Scattering intensity of polydisperse microgels
%   Parameter vector [rmean, std, sigs]
%   ampl
%   rmean
%   std
%   sigs

%	Stieger, M.; Pedersen, J. S.; Richtering, W.; Lindner, P. Journal of Chemical Physics 2004, 120, 6197?6206.

q = q(:);                                   % force to column vector
ampl = param(1);
rmean = param(2);
std = param(3);                             % std for radius distribution
sigs = param(4);                            % sigma surface, fuzziness factor


l = max([rmean-7*std 0]);
r = linspace(l,rmean+7*std,100);   % collocation points for radius distribution
w = mean(diff(r));                          % quadrature weight
%d = normpdf(r,rmean,std);                   % radius distribution
%d = wblpdf(r,rmean,std);                   % radius distribution
d = evpdf(r,rmean,std);

p = zeros(numel(q),1);

for i = 1:numel(r)
    
    pi = (3.*(sin(q.*r(i)) - q.*r(i).*cos(q*r(i))) ./ (q.*r(i)).^3 .* exp(-(sigs*q).^2 ./2)).^2;
    
    p = p + ampl .* w .* d(i) .* pi;                % weighted sum of form factors of each fraction
    
end % for

end

