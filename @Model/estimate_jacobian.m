function j = estimate_jacobian(p,delta_p,f,t,varargin)
%ESTIMATE_JACOBIAN Estimates the Jacobian for f numerically using finite
%differences
%   
% j = estimate_jacobian(p,delta_p,f,t)
% j = estimate_jacobian(p,delta_p,f,t,thr)
% j = estimate_jacobian(p,delta_p,f,t,thr,mi)
% 
% The function estimates the Jacobian by evaluating the ratio
% f(p+p_delta,t) - f(p-p_delta,t) / 2*delta_p.
%
% Parameters
% p             Parameter vector for f, where Jacobian will be estimated
% delta_p       Difference vector for p
% f             Function(handle) for which the Jacobian is estimated, f(p,t)
% t             Abscissa for f
% thr           Threshold for stopping the iterative refinement, 
%               norm(j-j_prev) / norm(j), where j is the Jacobian of the 
%               current iteration and that of j_prev of the previous 
%               iteration, default 1e-4
% mi            Maximum number of iterations, default 100
%
% Returns
% j             Jacobian for f
%
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved


threshold = 1e-4;
max_iter = 100;
j_prev = 0;

switch nargin
   
    case 4
        
        Lib.inargtchck(f, @(x) isa(x,'function_handle'),...
                   {p,delta_p,t}, @(x) all(cellfun(@isvector,x)));
        
    case 5
        
        Lib.inargtchck(f, @(x) isa(x,'function_handle'),...
                   {p,delta_p,t}, @(x) all(cellfun(@isvector,x)),...
                   varargin{1},@(x) numel(x) == 1 && x > 0 && x < 1);
        
        threshold = varargin{1};
       
    case 6
        
        Lib.inargtchck(f, @(x) isa(x,'function_handle'),...
                   {p,delta_p,t}, @(x) all(cellfun(@isvector,x)),...
                   varargin{1},@(x) numel(x) == 1 && x > 0 && x < 1,...
                   varargin{2},@(x) numel(x) == 1 && mod(x,1) == 0 && x > 0);
       
        threshold = varargin{1};
        max_iter = varargin{2};
        
    otherwise
        
        error('Wrong number of input arguments.');
    
end

       
for k = 1:max_iter       
     
    %% Calculate Jacobian
    
    j2 = zeros(numel(t),numel(p));
    j1 = zeros(numel(t),numel(p));

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

    j = d_f ./ d_p;             % Jacobian
   
    %% Check for threshold
    
    if k == 1           % first iteration, jump to k = 2
       
        j_prev = j;
        delta_p = delta_p ./ 2;
        continue;
        
    end
    
    j_delta = j_prev - j;
    
    if norm(j_delta)/norm(j_prev) <= threshold
        
        return;
        
    else
        
        j_prev = j;
        delta_p = delta_p ./ 2;
        
    end
    
end

warning(['Estimate_jacobian: Threshold was not met after ' num2str(max_iter) ' iterations.']);

end

