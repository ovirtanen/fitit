function si = initialize_si_axes(obj)
% scattered intensity

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.
        
si = axes('Parent',obj.axes_panel);
si.Tag = 'si_axes';
si.Units = 'normalized';
si.Position = [0.05 0.07 0.5 0.9];
        
si.YLabel.String = 'Intensity (cm^{-1})';
si.XLabel.String = 'q (nm^{-1})';
si.YScale = 'log';
        
si.Box = 'on';

m = obj.view.model;

% Add Graphics_source to the Axes_layout for plotting the model
          
q = linspace(0.0001,0.025,200)'; % q for plotting
intst = @()m.total_scattered_intensity(150,q);
    
gs = Graphics_source(si,'line',[0 0 0 0],q,intst);
obj.g_sources = [obj.g_sources gs];
            
% return to default units
si.Units = 'pixels';

end % initialize_si_axes()