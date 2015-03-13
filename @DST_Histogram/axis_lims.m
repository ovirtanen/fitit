function lims = axis_lims(obj)
%AXIS_LIMS Returns the axis limits for drawing the psd
%   
%   lims = axis_lims()
%
%   Returns
%   lims            [xmin xmax ymin ymax], if either pair is 0 0, LimMode
%                   is set to 'auto' in Graphics_source

xmax = obj.max_limit();

lims = [0 xmax 0 0];


end
