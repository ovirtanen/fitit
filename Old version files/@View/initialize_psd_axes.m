function initialize_psd_axes(obj,axes)
%INITIALIZE_PSD_AXES Summary of this function goes here
%   Detailed explanation goes here

m = obj.model;

x = m.rpsd;
y = m.psd;

%bar(axes,x,y,1,'white');
plot(axes,x,y);

axes.YLim = [0 1.1 .* max(y)];
axes.XLim = [0 cell2mat(m.fit_param(m.param_map('a_max')))];
axes.YLabel.String = 'P(r)';
axes.XLabel.String = 'Particle radius (nm)';

end

