function si = initialize_si_axes(obj)
% scattered intensity
        
si = axes('Parent',obj.axes_panel);
si.Tag = 'si_axes';
si.Units = 'normalized';
si.Position = [0.05 0.07 0.5 0.9];
        
si.YLabel.String = 'Intensity (cm^{-1})';
si.XLabel.String = 'q (nm^{-1})';
si.YScale = 'log';
        
si.Box = 'on';

m = obj.view.model;
ds = obj.view.model.data_sets;

% Add Graphics_sources to the Axes_layout
for i = 1:numel(ds)
          
    q = @()ds(i).q_mod();
    intst = @()m.total_scattered_intensity(100,ds(i).q_mod());
    
    gs = Graphics_source(si,'line',[0 0 0 0],q,intst);
    obj.g_sources = [obj.g_sources gs];
            
end % for

si.Units = 'pixels';

end % initialize_si_axes()