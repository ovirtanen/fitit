function p = weight(p,r1,r2,r3,w)
%WEIGHT Weights the psd according to the probabilities of obtaining certain
%combination and adds the integration weight.
%
% P(r1,r2,r3) = 6 * x1 * x2 * x3 ; r1 != r2 != r3
% P(r1,r1,r3) = 3 * x1^2 * x3
% P(r1,r1,r1) = x1^3

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

if r1 == r2 == r3       % all particles in triplet have the same size
    
    p = p .* w.^3;
    
elseif r1 == r2         % two particles in triplet have the same size
    
    p = 3 * p .* w.^3;
    
elseif r2 == r3         % two particles in triplet have the same size
    
    p = 3 * p .* w.^3;
    
else                    % all particles in triplet have different size
    
    p = 6 * p .* w.^3;
    
end % if

end % weight