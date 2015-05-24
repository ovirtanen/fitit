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
dr = 10.^obj.get_param('dr_val');

rprf = [linspace(0,m,100) m]; 
prf = [exp(dr.*(rprf(1:100) - m)) 0];

end

