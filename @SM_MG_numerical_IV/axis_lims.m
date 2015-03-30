function lims = axis_lims(obj)
%AXIS_LIMS Axis limits for the radial profile
%   
%   lims = axis_lims(obj)

xmax = obj.dist.max_limit();
lims = [0 xmax 0 1.1];

end

