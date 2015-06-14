function g = initialize_gui(obj)
%INITIALIZE_GUI Initializes the GUI on startup based on the default
%scattering model
%   
%   g = initialize_gui()
%
%   Returns
%   g           handle for the root Figure
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.


g = obj.initialize_figure();                % Root Figure

% Output panel initialization ---------------------------------------------

obj.active_layout = Axes_layout(obj,g,'default');
obj.layouts = [obj.layouts obj.active_layout];

% GUI elements & spacers initialization -----------------------------------

sm = obj.model.get_active_s_model;          % scattering model
dist = sm.dist;                             % distribution

obj.bg_panel = obj.initialize_bg_panel(g);            % BG panel

obj.p_panel = obj.initialize_param_panel(g,sm,'sm_panel');        % Panel for scattering model parameters
obj.d_panel = obj.initialize_param_panel(g,dist,'dist_panel');    % Panel for distribution parameters

obj.f_button = obj.initialize_fit_button(g);

op = obj.active_layout.axes_panel;
top_spacer = g.Position(4) - (op.Position(2) + op.Position(4)); % px
h_spacer = 10; % px
v_spacer = 10; % px
b_spacer = 30; % px; bottom spacer

% Resize root Figure if necessary -----------------------------------------

total_height = top_spacer + View.total_height_elements(v_spacer,obj.bg_panel,obj.p_panel,obj.d_panel,obj.f_button) + b_spacer;

obj.resize_figure(g,b_spacer,total_height);   

% Model controls alignment ------------------------------------------------

obj.align_control_panels(g,h_spacer,top_spacer,v_spacer,obj.bg_panel,obj.p_panel,obj.d_panel);

obj.bg_panel.Visible = 'on';
obj.p_panel.Visible = 'on';
obj.d_panel.Visible = 'on';

% Fit button alignment ----------------------------------------------------

h_pos = obj.d_panel.Position(1) + obj.d_panel.Position(3) - obj.f_button.Position(3);
v_pos = obj.d_panel.Position(2) - v_spacer - obj.f_button.Position(4);
obj.change_position(obj.f_button,h_pos,v_pos);

obj.f_button.Visible = 'on';

% Menu bar initialization -------------------------------------------------

obj.initialize_menu(g);

g.Visible = 'on';

end