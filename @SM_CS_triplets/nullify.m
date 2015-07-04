function a = nullify(a)
%NULLIFY Sets repeated permutations in array cube r1 x r2 x r3 to 0.
% Each point in the cube represents one combination for a triplet, e.g.
% three particles with radii 1, 2 and 3. The cube has however permutations
% of these combinations, e.g. 2, 1 and 3, which are unnecessary because
% this is accounted for by weighting (see function weight) and therefore
% only increase the number of calculations that have to be performed. Only
% one permutation will be preserved, others set to 0, so that they can be
% removed.
%
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

[~,~,z] = size(a);

for i = 2:z
   
    a(:,i-1,i:end) = 0;
    
end % for

end % nullify


