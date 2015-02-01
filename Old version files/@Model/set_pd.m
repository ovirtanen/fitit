function set_pd(obj,p)
%SET_PD Recalculates polarziation density profile of the mean particle
%radius.
%
%

%{
psd = obj.psd;

psd_mean = mean(psd);
larger = psd > psd_mean;
smaller = psd < psd_mean;
mean_index = larger & circshift(smaller,-1);
mean_radius = obj.rpsd(mean_index);
%}

mean_radius = obj.burr_moments(1,p(5),p(6),p(7));
[obj.rpd,obj.pd] = obj.pd_profile(obj.nc,mean_radius,p(1),p(2),p(3));

end

