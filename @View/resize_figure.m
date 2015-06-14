function resize_figure(obj,rfig,bottom_spacer,new_height)
%RESIZE_FIGURE Resizes the root Figure in FitIt gui
%
%   resize_figure(bottom_spacer, new_height) resizes the root Figure of the
%   gui so that the top edge position of the output_panel stays constant.
%   If new_height is smaller than minimum height specified by the op_panel
%   position and bottom_spacer, root Figure will not be resized.
%
%   Parameters
%   rfig                The root figure
%   bottom_spacer       Minimum distance between the op_panel and the root
%                       Figure bottom in px
%   new_height          New height in px. Has to include top and bottom
%                       spacers
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.


op = obj.active_layout.axes_panel;
o_units = op.Units;
op.Units = 'pixels';

top_v_spacer = rfig.Position(4) - (op.Position(2) + op.Position(4)); %px
min_height = top_v_spacer + op.Position(4) + bottom_spacer;

new_height = max([new_height min_height]);

delta = new_height - rfig.Position(4);

op.Position(2) = op.Position(2) + delta;

rfig.Position(2) = rfig.Position(2) - delta;
rfig.Position(4) = new_height;


op.Units = o_units;

end

