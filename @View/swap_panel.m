function swap_panel(obj,tag)
%SWAP_PANEL Deletes and reinitializes parameter panel and 
%redraws the GUI
%   
%   swap_p_panel(tag)
%
%   Parameters
%   tag         Tag of the parameter panel to be swapped, 'dist_panel' or
%               'sm_panel'

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

obj.d_panel.Visible = 'off';
obj.f_button.Visible = 'off';

sm = obj.model.get_active_s_model;          % scattering model
dist = sm.dist;                             % distribution

switch tag

    case 'dist_panel'
        
        delete(obj.d_panel);
        obj.d_panel = obj.initialize_param_panel(obj.gui,dist,tag);
        
    case 'sm_panel'
        
        delete(obj.p_panel);
        obj.p_panel = obj.initialize_param_panel(obj.gui,sm,tag);
        
    case 'bg_panel'
        
        delete(obj.bg_panel);
        obj.bg_panel = obj.initialize_bg_panel(obj.gui);
        
    otherwise
        
        error('Panel tag not recognized.')
   
end

% Spacers -----------------------------------------------------------------

op = obj.active_layout.axes_panel;
top_spacer = obj.gui.Position(4) - (op.Position(2) + op.Position(4)); % px
h_spacer = 10; % px
v_spacer = 10; % px
b_spacer = 30; % px; bottom spacer

% Resize root Figure if necessary -----------------------------------------

total_height = top_spacer + View.total_height_elements(v_spacer,obj.bg_panel,obj.p_panel,obj.d_panel,obj.f_button) + b_spacer;

obj.resize_figure(obj.gui,b_spacer,total_height);

% Model controls alignment ------------------------------------------------

obj.align_control_panels(obj.gui,h_spacer,top_spacer,v_spacer,obj.bg_panel,obj.p_panel,obj.d_panel);

obj.p_panel.Visible = 'on';
obj.d_panel.Visible = 'on';
obj.bg_panel.Visible = 'on';

% Fit button alignment ----------------------------------------------------
b = obj.f_button;
h_pos = obj.d_panel.Position(1) + obj.d_panel.Position(3) - b.Position(3);
v_pos = obj.d_panel.Position(2) - v_spacer - b.Position(4);
obj.change_position(b,h_pos,v_pos);

b.Visible = 'on';

obj.update_axes();

end



