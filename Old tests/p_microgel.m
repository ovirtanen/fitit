function p = p_microgel(param,q)
%P_MICROGEL Form factor of a microgel
%   p = p_microgel(param,q), where q is the vector containing q values and param
%   the parameter vector [r,sigs]. Here r is the hard sphere radius and 
%   sigs the decay constant for the microgel density. The function
%   returns the form factor p at q.

r = param(1);
sigs = param(2);

p = (3.*(sin(q.*r) - q.*r.*cos(q*r)) ./ (q.*r).^3 .* exp(-(sigs*q).^2./2)).^2;


end

