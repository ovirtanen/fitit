function [bg,pp,dp,b] = initialize_smodel_controls(obj,f)
%INITIALIZE_SMODEL_CONTROLS Initializes the parameter input section in gui
%
%   [bg,pp,dp,b] = initialize_smodel_controls(f)
%
%   Parameters
%   f           handle to the root Figure instance
%
%   Returns
%   bg          handle to background panel
%   pp          handle to scattering model parameter panel
%   dp          handle to distribution parameter panel
%   b           handle to the fit button
%


if isempty(obj.layouts)
   error('Layout has to be initialized first.'); 
end






%%% Check that the controls fit into the root Figure and resize if
%%% necessary--------------------------------------------------------------

% top_align = Position of the output_panel top edge
op = findobj(f,'Tag','output_panel');
top_align = op.Position(2) + op.Position(4);

top_v_spacer = f.Position(4)-top_align;     %px
panel_v_spacer = 10;                        %px
panel_h_spacer = 10;                        %px

% Total height of the smodel controls
total_height = top_v_spacer + 5.* panel_v_spacer + bg.Position(4) + pp.Position(4) + dp.Position(4) + b.Position(4);

if total_height > f.Position(4)
   
    obj.resize_figure(total_height);
    
end % if

%%% Position the controls to the root Figure ------------------------------

% .Postion : [left bottom width height]

top_align = op.Position(2) + op.Position(4);    % calculate new top_align if the Figure size changes
h_pos = top_align - bg.Position(4);
obj.change_position(bg,panel_h_spacer,h_pos);

h_pos = h_pos - panel_v_spacer - pp.Position(4);
obj.change_position(pp,panel_h_spacer,h_pos);

h_pos = h_pos - panel_v_spacer - dp.Position(4);
obj.change_position(dp,panel_h_spacer,h_pos);

h_pos = h_pos - panel_v_spacer - b.Position(4);
v_pos = panel_h_spacer + dp.Position(3) - b.Position(3);
obj.change_position(b,v_pos,h_pos);


%%% Make gui elements visible ---------------------------------------------

bg.Visible = 'on';
pp.Visible = 'on';
dp.Visible = 'on';
b.Visible = 'on';

end


