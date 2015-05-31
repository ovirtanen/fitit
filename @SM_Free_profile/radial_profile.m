function [rprf,prf] = radial_profile(obj)
%RADIAL_PROFILE Radial profile of a hard sphere for the mean particle
%radius
%   
%   [rprf,prf] = radial_profile()
%
%   Returns
%   rprf        Radial points from the center of the particle
%   prf         Radial profile    
%
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

m = obj.dist.mean();
n = obj.n;

rprf = ((1:n)./n)' .* m; 
rprf = repelem(rprf,3);
rprf(numel(rprf)) = [];
rprf = [0;rprf];

prf = cell2mat(obj.params(:,2));
prf(1) = [];
prf = repelem(prf,3);
prf(3:3:end) = 0;

end

