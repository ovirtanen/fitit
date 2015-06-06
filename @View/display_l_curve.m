function display_l_curve(obj,snorm,rnorm,lambda)
%DISPLAY_L_CURVE Displays L-curve for SM_Free_profile
%   Detailed explanation goes here


f = figure();

l = scatter(rnorm,snorm);
a = f.Children(1);

a.YScale = 'log';
a.XScale = 'log';
a.YLim = [0.9*min(l.YData) 1.1*max(l.YData)];
a.XLim = [0.9*min(l.XData) 1.1*max(l.XData)];

lambda = num2cell(lambda);
lambda = cellfun(@num2str,lambda,'UniformOutput',0);

text(1.01.*rnorm,1.01*snorm,lambda);

a.YLabel.String = 'Inverse solution norm';
a.XLabel.String = 'Residual norm';
box on;

end

