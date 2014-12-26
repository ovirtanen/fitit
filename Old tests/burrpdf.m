function d = burrpdf(x,a,c,k)
%BURRPDF Burr type XII probability density function
%   Detailed explanation goes here

d = (k.*c./a).*(x./a).^(c-1)./ (1 + (x./a).^c).^(k+1);
d = real(d);        % for some reason Matlab wants to add 0.00...i component to output

end

