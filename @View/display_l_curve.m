function display_l_curve(obj,snorm,rnorm,lambda)
%DISPLAY_L_CURVE Displays L-curve for SM_Free_profile
%   Detailed explanation goes here


f = figure();

l = scatter(rnorm,snorm);
a = f.Children(1);

a.YScale = 'log';
a.XScale = 'log';



lambda = num2cell(lambda);
lambda = cellfun(@num2str,lambda,'UniformOutput',0);

text(rnorm,snorm,lambda);

a.YLabel.String = 'Solution norm';
a.XLabel.String = 'Residual norm';
box on;

end

