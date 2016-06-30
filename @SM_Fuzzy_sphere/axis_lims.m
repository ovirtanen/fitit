function lims = axis_lims(obj)
%AXIS_LIMS Axis limits for the radial profile
%   
%   lims = axis_lims(obj)

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

xmax = obj.dist.max_limit();
lims = [0 xmax 0 1.1];

end

