function [rprf,prf] = radial_profile(obj)
%RADIAL_PROFILE Radial profile of a core shell particle for the mean particle
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
rc = m .* obj.get_param('frc_val') ./ 100;
pdc = obj.get_param('pdc_val');
pds = obj.get_param('pds_val');

rprf = [0 rc rc m m];
prf = [pdc pdc pds pds 0];


end

