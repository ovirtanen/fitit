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

end

