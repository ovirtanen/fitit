function [rprf, prf] = radial_profile(obj)
%RADIAL_PROFILE Radial profile for Stieger microgel
%
%   [rprf,prf] = radial_profile()
%

nc = 100;
rhard = obj.dist.mean();
sd = obj.get_param('sd_val');
cpd = obj.get_param('cpd_val');
mxspd = obj.get_param('mxspd_val');
fuzz = obj.get_param('fuzz_val');

[rprf, prf] = SM_MG_numerical_II.pd_profile(nc,rhard,sd,cpd,mxspd,fuzz);

end

