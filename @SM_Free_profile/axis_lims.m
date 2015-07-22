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
ymax = 1.1.*max(cell2mat(obj.params(end-obj.n+1:end,2)));
lims = [0 xmax 0 ymax];

end

