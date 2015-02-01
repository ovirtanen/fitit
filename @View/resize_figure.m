function resize_figure(obj,new_height)
%RESIZE_FIGURE Resizes the root Figure in FitIt gui
%
%   resize_figure(new_height) resizes the root Figure of the gui so that
%   the top edge position of the output_panel stays constant.
%
%


op = findobj(obj.gui,'Tag','output_panel');

top_v_spacer = obj.gui.Position(4)-op.Position(2)-op.Position(4); %px
min_height = top_v_spacer + op.Position(2) + op.Position(4);

if new_height <= min_height
    return;
end;

delta = new_height - obj.gui.Position(4);

op.Position(2) = op.Position(2) + delta;

obj.gui.Position(4) = new_height;

end

