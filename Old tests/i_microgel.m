function [p,r,d,w]= i_microgel(param,q)
%I_microgel Scattering intensity of polydisperse microgels
%   [p,r,d,w]= i_microgel(param,q) returns the scaled form factor p at
%   scattering vector values q. r, d and w are the collocation points, pdf
%   values and the quadrature weight for the particle size distribution,
%   respectively. Parameter vector is given below.
%
%   Parameter vector [ampl a c k sigs]
%
%   ampl            scaling factor or "intensity" for the form factor
%   a               Burr parameter a, "overall radius parameter"
%   c               Burr parameter c, "width parameter"
%   k               Burr parameter k, "right tail parameter"
%   sigs            Fuzziness parameter of the microgel periphery

%	Stieger, M.; Pedersen, J. S.; Richtering, W.; Lindner, P. Journal of Chemical Physics 2004, 120, 6197?6206.

q = q(:);                                   % force to column vector
ampl = param(1);

% parameters for the Burr distribution
a = param(2);                               % "radius parameter"
c = param(3);                               % shape parameters         
k = param(4);                               %       -"-

sigs = param(5);                            % sigma surface, fuzziness factor

l = max([a-7*c 0]);                         % safety check for not slipping to negative
r = linspace(l,a+7*c,100);                  % collocation points for radius distribution
w = mean(diff(r));                          % quadrature weight, get rid of rounding errors

% pdf at collocation points
d = burrpdf(r,a,c,k);
f = r > 0;
d = d(f);
r = r(f);

p = zeros(numel(q),1);

for i = 1:numel(r)
    
    pi = (3.*(sin(q.*r(i)) - q.*r(i).*cos(q*r(i))) ./ (q.*r(i)).^3 .* exp(-(sigs*q).^2./2)).^2;
    
    p = p + ampl .* w .* d(i) .* pi;                % weighted sum of form factors of each fraction
    
end % for

end

