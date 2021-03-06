function d = initialize_dist_axes(obj,si)
% distribution function
% expects si units to be normalized
%
% pos = [left bottom width height]
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

o_units = si.Units;
si.Units = 'normalized';

d = axes('Parent',obj.axes_panel);
d.Tag = 'dist_axes';
d.Units = 'normalized';
  
% Position & size ---------------------------------------------------------

si_pos = si.Position;
min_left = si_pos(1) + si_pos(3);
bottom_align = si_pos(2);
        
d_height = 0.40;
d_width = 0.35;
left_offset = 0.07;
        
d.Position = [min_left+left_offset bottom_align d_width d_height];

% Other axes properties---------------------------------------------------

d.YLabel.String = 'P(r)';
d.XLabel.String = 'Particle radius (nm)';
        
d.Box = 'on';

% Add Graphics_source to the Axes_layout-----------------------------------

nc = obj.view.model.nc;

al = @()obj.view.model.get_active_s_model().dist.axis_lims;
di = @()obj.view.model.get_active_s_model().dist.psd(nc,obj.view.model.get_active_s_model().dist.get_param_vector());

gs = Graphics_source(d,'bar',al,di);
obj.g_sources = [obj.g_sources gs];


si.Units = o_units;

end % initialize_dist_axes()
