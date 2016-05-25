function j = estimate_jacobian(p,f,t)
%ESTIMATE_JACOBIAN Estimates the Jacobian for f numerically using finite
%differences
%   
% j = estimate_jacobian(p,delta_p,f,t)
% 
% The function estimates the Jacobian by evaluating the ratio
% f(p+p_delta,t) - f(p-p_delta,t) / 2*p_delta.
% 
% p_delta is given by nthroot(p,3).*p (Numerical Recipes 3rd. ed. p.230)
%
% Parameters
% p             Parameter vector for f, where Jacobian will be estimated
% f             Function(handle) for which the Jacobian is estimated, f(p,t)
% t             Abscissa for f
%
% Returns
% j             Jacobian for f
%
%
% 

% Copyright (c) 2015, 2016, Otto Virtanen
% All rights reserved
        
Lib.inargtchck(f, @(x) isa(x,'function_handle'),...
           {p,t}, @(x) all(cellfun(@isvector,x)));
       
%% Calculate Jacobian
    
j2 = zeros(numel(t),numel(p));
j1 = zeros(numel(t),numel(p));

delta_p = nthroot(eps(1),3) .* p;

for i = 1:numel(p)

    p2 = p;
    p2(i) = p2(i) + delta_p(i);

    j2(:,i) = f(p2,t);

    p1 = p;
    p1(i) = p1(i) - delta_p(i);

    j1(:,i) = f(p1,t);

end

d_f = j2 - j1;
d_p = ones(numel(t),1) * (2.*delta_p(:)');

j = -1 .* d_f ./ d_p;             % Jacobian
   
end

