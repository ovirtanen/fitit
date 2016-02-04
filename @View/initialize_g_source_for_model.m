function initialize_g_source_for_model(obj)
%INITIALIZE_G_SOURCE_FOR_MODEL Initializes Graphics_source instance for
%total scattered intensity
%   

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

si = findobj(obj.active_layout.axes_panel,'Tag','si_axes');

% Set the Graphics Root object to FitIt figure and output to si axes. This
% prevents the FitIt figure from jumping to the users face every time a new
% Graphics source is initialized.
obj.graphics_root.CurrentFigure = obj.gui;
obj.graphics_root.CurrentFigure.CurrentAxes = si;


m = obj.model;
q = linspace(0.0001,0.025,200)';
ihandles = @() 1:numel(obj.model.handles);
nc = m.nc;
intst = @()m.total_scattered_intensity(nc,ihandles(),q);

gs = Graphics_source(si,'line',[0 0 0 0],q,intst);
obj.active_layout.add_g_source(gs);


end

