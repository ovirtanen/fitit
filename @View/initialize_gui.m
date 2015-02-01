function g = initialize_gui(obj)
%INITIALIZE_GUI Initializes the GUI on startup based on the default
%scattering model
%   
%   g = initialize_gui()
%
%   Returns
%   g           handle for the root Figure
%


g = obj.initialize_figure();                % Root Figure

obj.active_layout = Axes_layout(obj,g,'default');
obj.layouts = [obj.layouts obj.active_layout];

[obj.bg_panel,...
 obj.p_panel,...
 obj.d_panel,...
 obj.f_button] = obj.initialize_smodel_controls(g);

g.Visible = 'on';

end