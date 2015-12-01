function p = initialize_pupdate_panel(obj,panel_width)
%INITIALIZE_PUPADATE_PANEL Initialize Parameter update policy -panel
%   
%
% Parameters
% width         Width of the panel in px
%
% Returns
% p             Panel
%
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

p = uibuttongroup(obj.gui);
p.Units = 'pixels';
p.Title = 'Parameter update policy';

% Spacers & heights

rbtn_spacer = obj.spacers.rbtn_spacer;          % Radio button spacer
rbtn_height = obj.spacers.rbtn_height;          % Radio button height

% Calculate size parameters

panel_height = 3.* rbtn_spacer + 2.*rbtn_height;
rbtn_width = 0.9.*panel_width;

p.Position(3:4) = [panel_width panel_height];

% Radio buttons
        
r1 = uicontrol(p,'Style','radiobutton');
r1.Units = 'pixels';
r1.String = 'Always keep updated';
r1.Position = [(panel_width - rbtn_width)./2 panel_height-(rbtn_spacer+rbtn_height) rbtn_width rbtn_height];

r2 = uicontrol(p,'Style','radiobutton');
r2.Units = 'pixels';
r2.String = 'Update only after fit';
r2.Position = [(panel_width - rbtn_width)./2 panel_height-2.*(rbtn_spacer+rbtn_height) rbtn_width rbtn_height];

end

