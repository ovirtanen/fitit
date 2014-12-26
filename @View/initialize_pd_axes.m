function initialize_pd_axes(obj,axes)
%INITIALIZE_PD_AXES Summary of this function goes here
%   Detailed explanation goes here


m = obj.model;

x = m.rpd;
y = m.pd;

plot(axes,x,y);


axes.YLabel.String = 'Polarization density (a.u.)';
axes.XLabel.String = 'Radial distance (nm)';
axes.YLim = [0 1.1 .* max(y)];
axes.XLim = [0 cell2mat(m.fit_param(m.param_map('meanr_max')))];

end

