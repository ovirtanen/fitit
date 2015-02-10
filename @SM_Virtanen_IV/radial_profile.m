function [rprf, prf] = radial_profile(obj)
%RADIAL_PROFILE Radial profile for Stieger microgel
%
%   [rprf,prf] = radial_profile()
%

nc = 100;
rinc = obj.get_param('pnd_val');
rhard = obj.dist.mean();
sthck = obj.get_param('sth_val');
vcore = obj.get_param('cpd_val');
vskin = obj.get_param('mxspd_val');
fuzz = obj.get_param('fuzz_val');


[rprf, prf] = SM_Virtanen_IV.pd_profile(nc,rinc,rhard,sthck,vcore,vskin,fuzz);

end

