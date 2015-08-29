function lims = axis_lims(obj)
%AXIS_LIMS Returns the axis limits for drawing the radial profile
%   
%
% Returns
% lims          [xmin xmax ymin ymax]
%
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

n = obj.n;
dprf = cell2mat(obj.params(:,2));
dprf = dprf(end-n+2:end);
prf = cumsum([dprf;1],'reverse');

xmax = obj.dist.max_limit();

ymax = max(1.1.*max(prf),0.9.*max(prf));
ymin = min(1.1.*min(prf),0.9.*min(prf));


lims = [0 xmax ymin ymax];

end

