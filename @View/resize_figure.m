function resize_figure(obj,bottom_spacer,new_height)
%RESIZE_FIGURE Resizes the root Figure in FitIt gui
%
%   resize_figure(bottom_spacer, new_height) resizes the root Figure of the
%   gui so that the top edge position of the output_panel stays constant.
%   If new_height is smaller than minimum height specified by the op_panel
%   position and bottom_spacer, root Figure will not be resized.
%
%   Parameters
%   bottom_spacer       Minimum distance between the op_panel and the root
%                       Figure bottom in px
%   new_height          New height in px. Has to include top and bottom
%                       spacers
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.


op = findobj(obj.gui,'Tag','output_panel');
o_units = op.Units;
op.Units = 'pixels';

top_v_spacer = obj.gui.Position(4)-(op.Position(2)+op.Position(4)); %px
min_height = top_v_spacer + op.Position(2) + op.Position(4) + bottom_spacer;

if new_height <= min_height
    return;
end;

delta = new_height - (obj.gui.Position(4) + bottom_spacer);

op.Position(2) = op.Position(2) + delta;

obj.gui.Position(4) = new_height;

op.Units = o_units;

end

