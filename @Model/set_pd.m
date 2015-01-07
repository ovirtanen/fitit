function set_pd(obj,p)
%SET_PD Recalculates polarziation density profile of the mean particle
%radius.
%   Detailed explanation goes here


[obj.rpd,obj.pd] = obj.pd_profile(obj.nc,p(5),p(1),p(2),p(3));

end

