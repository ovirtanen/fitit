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

m = obj.dist.mean();
n_points = 99;
rprf = zeros(n_points+1,1);
rprf(1:end-1) = linspace(0,m,n_points)';
rprf(end) = rprf(end-1);

prf = ones(n_points+1,1);
prf(end) = 0;

end

