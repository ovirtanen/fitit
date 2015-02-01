function lims = axis_lims(obj)
%AXIS_LIMS Returns the axis limits for drawing the radial profile
%   
%
% Returns
% lims          [xmin xmax ymin ymax]
%
%

xmax = obj.dist.max_limit();
lims = [0 xmax 0 1.1];

end

