function [qm,rm,dq,varargout] = res_discretize(qn,s2,n)
%RES_DISCRETIZE Discretize the resolution function to a given number of
%integration points
%
%   [qm,rm,dq] = res_discretize(qn,s2,n)
%   
% Parameters
% qn            Vector of nominal q values (experimental q values) [1 x k double]
% s2            Variance for nominal q values [1 x k double]
% n             Number of integration points in the discretization [1 x 1 double]
%
% Returns
% qm            q matrix where each column corresponds holds integration
%               points for a single q value in qn [n x k double]
% rm            Resolution function matrix holding the value of the
%               resolution function at qm [n x k double]
% dq            Integration weight for each column [1 x k double]

% Copyright (c) 2015, 2016 Otto Virtanen
% All rights reserved.

%% Basic check for the input arguments

if not(all([isvector(qn) isvector(s2) numel(qn) == numel(s2) numel(n) == 1]))
    
    error('Invalid input arguments.');
    
end

%% Orientation of the vectors

qn = qn(:)';
s2 = s2(:)';

%% See if the last distribution function leaks out of the nominal q vector
% If it does, expand the vector.

threshold = 1e-3;       % Threshold relative to the maximum of the distribution
failsafe = 10;
iterate = true;
q = linspace(0,max(qn),300);
j = 1;

while(iterate)
    
    if j >= failsafe
        
        error('Failsafe.');
        
    end
    
    rm = Data_set.res_function(q,qn(end),s2(end));
    d = diff(rm) ./ diff(q);                   % simple derivative
    
    % Extend the grid if maximum has not been passed or the function has
    % not decayed beyont the threshold
    if numel(unique(sign(d))) == 1 || rm(end) > threshold * max(rm)
       
        q = linspace(0,1.5.*max(q),200);
        
    else
        
        iterate = false;
        
    end
    
    j = j + 1;
    
end

if nargout > 3
   
    varargout{1} = q;
    
end

% Calculate the resolution function for each q entry using the expanded q
% vector as the grid.
r = zeros(numel(q),numel(qn));
for i = 1 : numel(qn)
   
    r(:,i) = Data_set.res_function(q,qn(i),s2(i));
    
end

if nargout > 3
   
    varargout{2} = r;
    
end

% maximum of each column, i.e. resolution function
t = max(r) .* threshold;

% recognize values in each resolution function that exceed the threshold t
r = bsxfun(@ge,r,t);

% Find integration limits for the distribution functions
lims = zeros(size(r,2),2);

for i = 1:size(r,2)
   
    indices = find(r(:,i));
    lims(i,:) = [q(min(indices)) q(max(indices))];
    
end

qm = zeros(n,numel(qn));
rm = zeros(n,numel(qn));
dq = zeros(1,n);

for i = 1:numel(qn)

    delta = lims(i,2) - lims(i,1);                  % distance between min and max q integration limit
    dq(i) = delta ./ n;                             % divide delta to n intervals
    qm(:,i) = (1:n) - 0.5;
    qm(:,i) = lims(i,1) + qm(:,i) .* dq(i);         % integration points
    
    rm(:,i) = Data_set.res_function(qm(:,i),qn(i),s2(i));
    rm(:,i) = rm(:,i) ./ (dq(i).*sum(rm(:,i)));     % A (questionable?) trick to bring the integral to 1
    
end

