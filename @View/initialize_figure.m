function h = initialize_figure(obj)
%INITIALIZE_FIGURE Initializes the parent figure for FitIt
%
%   h = initialize_figure()
%
% Returns
% h         handle for the Figure instance, 'Visible' 'off'
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

h = figure('Name','FitIt!','Visible','off');
h.Tag = 'Root';
h.NumberTitle = 'off';
h.ToolBar = 'none';
h.MenuBar = 'none';

h.Units = 'normalized';
h.Position = [0.015 0.3 0.97 0.6]; %[left bottom width height]
h.Resize = 'off';

h.Units = 'pixels';

%{
% initialize axes

si = initialize_si_axes();
cp = initialize_cp_axes();
d = initialize_dist_axes();

% Return to default units

h.Units = 'pixels';
si.Units = 'pixels';
cp.Units = 'pixels';
d.Units = 'pixels';



    function si = initialize_si_axes()
         % scattered intensity
        
        si = axes('Parent',h);
        si.Tag = 'si_axes';
        si.Units = 'normalized';
        si.Position = [0.45 0.1 0.3 0.8];
        
        si.YLabel.String = 'Intensity (cm^{-1})';
        si.XLabel.String = 'q (nm^{-1})';
        si.YScale = 'log';
        
        si.Box = 'on';
        
        m = obj.model;
        ds = obj.model.data_sets;
        
        for i = 1:numel(ds)
            
            x = ds(i).q_mod;
            gs = Graphics_source(si,'line',x,@()m.total_scattered_intensity(100,x));
            obj.g_sources = [obj.g_sources gs];
            
        end % for
        
    end % initialize_si_axes()

    function cp = initialize_cp_axes()
        % contrast profiles
        % expects si units to be normalized
        
        cp = axes('Parent',h);
        cp.Tag = 'cp_axes';
        cp.Units = 'normalized';
        
        si_pos = si.Position;
        min_left = si_pos(1) + si_pos(3);
        top_align = si_pos(2) + si_pos(4);
        
        cp_height = 0.35;
        cp_width = 0.20;
        left_offset = 0.03;
        cp.Position = [min_left+left_offset top_align-cp_height cp_width cp_height];
        
        cp.YLabel.String = 'Polarization density (a.u.)';
        cp.XLabel.String = 'Radial distance (nm)';
        
        cp.Box = 'on';
        
    end % initialize_cp_axes()

    function d = initialize_dist_axes()
        % distribution function
        % expects si units to be normalized
        
        d = axes('Parent',h);
        d.Tag = 'dist_axes';
        d.Units = 'normalized';
        
        si_pos = si.Position;
        min_left = si_pos(1) + si_pos(3);
        bottom_align = si_pos(2);
        
        d_height = 0.35;
        d_width = 0.20;
        left_offset = 0.03;
        
        d.Position = [min_left+left_offset bottom_align d_width d_height];
        
        d.YLabel.String = 'P(r)';
        d.XLabel.String = 'Particle radius (nm)';
        
        d.Box = 'on';
        
    end % initialize_dist_axes()

%}
end

