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

rprf = [0 m m]; 
prf = [1 1 0];

end

