function initialize_form_factor_axes(obj,axes)
%INITIALIZE_FORM_FACTOR_AXES Initializes form_factor_axes
% 
% Parameters
% 
% axes      form_factor_axes
%

m = obj.model;

x = m.qfit;
y = m.fit;

plot(axes,x,y);

axes.YLabel.String = 'Intensity (cm^{-1})';
axes.XLabel.String = 'q (nm^{-1})';
axes.YScale = 'log';
axes.YLim = [0.5.*min(y) 5*max(y)];

end

