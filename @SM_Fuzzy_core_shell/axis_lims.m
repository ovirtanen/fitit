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

pdc = obj.get_param('vfc_val');
pds = obj.get_param('vfs_val');

xmax = obj.dist.max_limit();
lims = [0 xmax 0 1.1 .* max([1 pdc pds])];

end

