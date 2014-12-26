function p = i_sphere(param,q)
%I_SPHERE Summary of this function goes here
%   Detailed explanation goes here

q = q(:);                                   % force to column vector
ampl = param(1); 
rmean = param(2);
std = param(3);

r = linspace(rmean-3*std,rmean+3*std,20);   % collocation points for radius distribution
w = mean(diff(r));                          % quadrature weight
%d = normpdf(r,rmean,std);                   % radius distribution
d = evpdf(r,rmean,std); 

p = zeros(numel(q),1);

for i = 1:numel(r)
    
    pi = (3.*(sin(q.*r(i)) - q.*r(i).*cos(q*r(i))) ./ (q.*r(i)).^3).^2;
    
    p = p + ampl .* w .* d(i) .* pi;                % weighted sum of form factors of each fraction
    
end % for

end

