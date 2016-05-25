function lims = axis_lims(obj)
%AXIS_LIMS Returns the axis limits for drawing the psd
%   
%   lims = axis_lims()
%
%   Returns
%   lims            [xmin xmax ymin ymax], if either pair is 0 0, LimMode
%                   is set to 'auto' in Graphics_source

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

xmax = nthroot(3.*obj.get_param('mean_max')./(4.*pi),3);

lims = [0 xmax 0 0];


end

