function [rprf, prf] = radial_profile(obj)
%RADIAL_PROFILE Radial profile for Stieger microgel
%
%   [rprf,prf] = radial_profile()
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

nc = 100;
rhard = obj.dist.mean();
tau = obj.get_param('dr_val');
vskin = obj.get_param('mxspd_val');
fuzz = obj.get_param('fuzz_val');

[rprf, prf] = SM_MG_numerical.pd_profile(nc,rhard,tau,vskin,fuzz);

end

