function [rprf, prf] = radial_profile(obj)
%RADIAL_PROFILE Radial profile for Stieger microgel
%
%   [rprf,prf] = radial_profile()
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

nc = 100;
rhard = obj.dist.mean();
sthck = obj.get_param('sth_val');
tau = obj.get_param('dr_val');
vskin = obj.get_param('mxspd_val');
fuzz = obj.get_param('fuzz_val');


[rprf, prf] = SM_MG_numerical_III.pd_profile(nc,rhard,sthck,tau,vskin,fuzz);

end

