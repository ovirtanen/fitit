function p = initialize_save_panel(obj,panel_width)
%INITIALIZE_SAVE_PANEL Initialize Save panel
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

p = uipanel(obj.gui);
p.Units = 'pixels';
p.Title = 'Saving';

% Spacers and heights

b_group_spacer = obj.spacers.b_group_spacer;    % Radio button group spacer
rbtn_spacer = obj.spacers.rbtn_spacer;          % Radio button spacer
rbtn_height = obj.spacers.rbtn_height;          % Radio button height
btn_spacer = obj.spacers.btn_spacer;            % Push button spacer
btn_height = obj.spacers.btn_height;            % Push button spacer
checkbox_spacer = obj.spacers.checkbox_spacer;
checkbox_height = obj.spacers.checkbox_height;

% Calculate size parameters

checkbox_width = 0.9.*panel_width;
b_group_height = 3.*rbtn_spacer + 2.*rbtn_height;
panel_height = 5.* checkbox_spacer + 3.*checkbox_height + b_group_spacer + b_group_height + 2.*btn_spacer + btn_height;

p.Position(3:4) = [panel_width panel_height];

c1 = uicontrol(p,'Style','checkbox');
c1.Units = 'pixels';
c1.String = 'Autosave after batch fit';
c1.Position = [(panel_width  - checkbox_width)./2 panel_height-(1.*(checkbox_spacer+checkbox_height)+2.*checkbox_spacer) checkbox_width rbtn_height];

c2 = uicontrol(p,'Style','checkbox');
c2.Units = 'pixels';
c2.String = 'Export p to table';
c2.Position = [(panel_width  - checkbox_width)./2 c1.Position(2)-1.*(checkbox_spacer+checkbox_height) checkbox_width rbtn_height];

c3 = uicontrol(p,'Style','checkbox');
c3.Units = 'pixels';
c3.String = 'Export as text';
c3.Position = [(panel_width  - checkbox_width)./2 c2.Position(2)-1.*(checkbox_spacer+checkbox_height) checkbox_width rbtn_height];

% Radio button group

b_group = uibuttongroup(p);
b_group.Title = 'Manual save';
b_group.Units = 'pixels';

b_group_width = 0.9.*panel_width;

b_group.Position = [(panel_width-b_group_width)./2 c3.Position(2)-(b_group_spacer+b_group_height) b_group_width b_group_height];

% Radio buttons

    rbtn_width = 0.9.*b_group_width;

    r1 = uicontrol(b_group,'Style','radiobutton');
    r1.Units = 'pixels';
    r1.String = 'All';
    r1.Position = [(b_group_width - rbtn_width)./2 b_group_height-(rbtn_spacer+rbtn_height) rbtn_width rbtn_height];

    r2 = uicontrol(b_group,'Style','radiobutton');
    r2.Units = 'pixels';
    r2.String = 'Only selected';
    r2.Position = [(b_group_width - rbtn_width)./2 r1.Position(2)-(rbtn_spacer+rbtn_height) rbtn_width rbtn_height];
        
% Set path push button
btn = uicontrol(p,'Style','pushbutton');
btn.String = 'Set Path';
btn.Units = 'pixels';

btn_width = 0.9.*panel_width ./ 2;

btn.Position = [(panel_width-btn_width.*2)./2 b_group.Position(2)-(btn_spacer + btn_height)  btn_width btn_height];

btn = uicontrol(p,'Style','pushbutton');
btn.String = 'Save Now';
btn.Units = 'pixels';

btn.Position = [(panel_width-btn_width.*2)./2 + btn_width b_group.Position(2)-(btn_spacer + btn_height) btn_width btn_height];
end

