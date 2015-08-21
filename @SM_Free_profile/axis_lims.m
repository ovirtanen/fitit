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

xmax = obj.dist.max_limit();
ymax = 1.1.*max(cumsum([cell2mat(obj.params(end-obj.n+2:end,2));1],'reverse'));
lims = [0 xmax 0 ymax];

end

