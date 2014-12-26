function y = b(r,rbox,m)
%B Box profile function
%   y = b(m,r), returns m on the interval [-rbox,rbox] and 0 everywhere else 
%   on the radial axis vector r.

f = r >= -rbox & r <= rbox;

y = zeros(numel(r),1);

y(f) = m;

end

