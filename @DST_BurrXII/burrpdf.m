function d = burrpdf(r,a,c,k)
%BURRPDF Burr type XII probability density function
%
% Parameters
%
% r             Points where the pdf is evaluated
% p_a           Burr parameter a, location parameter
% p_c           Burr parameter c, "left skewness" parameter
% p_k           Burr parameter k, "right skewness" parameter


d = (k.*c./a).*(r./a).^(c-1)./ (1 + (r./a).^c).^(k+1);
d = real(d);        % for some reason Matlab wants to add 0.00...i component to output

end

