function si = initialize_si_axes(obj)
% scattered intensity

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

%% Axis position

si = axes('Parent',obj.axes_panel);
si.Tag = 'si_axes';
si.Units = 'normalized';
si.Position = [0.05 0.07 0.5 0.9];
 
%% Axis labels & box

si.YLabel.String = 'Intensity (cm^{-1})';
si.XLabel.String = 'q (nm^{-1})';
si.YScale = 'log';
        
si.Box = 'on';


%% Add Graphics_source to the Axes_layout for plotting the model
 
m = obj.view.model;
q = m.q_fit;

switch isempty(m.q_br) % check if back reflection is in use
    
    case 0
        
        intst = @()m.total_scattered_intensity(150,q,m.q_br,m.eta);
        
    case 1
        
        intst = @()m.total_scattered_intensity(150,q);
        
end % switch

gs = Graphics_source(si,'line',[0 0 0 0],q,intst);
obj.g_sources = [obj.g_sources gs];
    
gs = Graphics_source(si,'line',[0 0 0 0],q,intst);
obj.g_sources = [obj.g_sources gs];
            
            
%% return to default units
si.Units = 'pixels';

end % initialize_si_axes()