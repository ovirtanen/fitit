function cp = initialize_cp_axes(obj,si)
% contrast profiles
% expects si units to be normalized
     
o_units = si.Units;
si.Units = 'normalized';

cp = axes('Parent',obj.axes_panel);
cp.Tag = 'cp_axes';
cp.Units = 'normalized';

% Position & size ---------------------------------------------------------

si_pos = si.Position;
min_left = si_pos(1) + si_pos(3);
top_align = si_pos(2) + si_pos(4);
        
cp_height = 0.40;
cp_width = 0.35;
left_offset = 0.07;
cp.Position = [min_left+left_offset top_align-cp_height cp_width cp_height];

% Other axes properties---------------------------------------------------

cp.YLabel.String = 'Polarization density (a.u.)';
cp.XLabel.String = 'Radial distance (nm)';
        
cp.Box = 'on';

% Add Graphics_sources to the Axes_layout-----------------------------------

% zero line
al = @()obj.view.model.get_active_s_model().axis_lims();

xlims = @(x)x(1:2);
gs = Graphics_source(cp,'line',al(),xlims(al()),[0 0]);
gs.set_grapho_properties('Color',[0 0 0],'LineWidth',0.25);
obj.g_sources = [obj.g_sources gs];

% Radial profile

prf = @()obj.view.model.get_active_s_model().radial_profile();

gs = Graphics_source(cp,'line',al,prf);
obj.g_sources = [obj.g_sources gs];


si.Units = o_units;

end % initialize_cp_axes()
