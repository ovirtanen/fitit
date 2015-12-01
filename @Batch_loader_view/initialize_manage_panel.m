function p = initialize_manage_panel(obj,panel_width)
%INITIALIZE_MANAGE_PANEL Initializes Manage data -panel in Batchloader GUI
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
p.Title = 'Manage data';
p.Units = 'pixels';

% Spacers & heights

btn_spacer = obj.spacers.btn_spacer;            % Push button spacer
rbtn_spacer = obj.spacers.rbtn_spacer;          % Radio button spacer
b_group_spacer = obj.spacers.b_group_spacer;    % Radio button group spacer

btn_height = obj.spacers.btn_height;            % Push button height
rbtn_height = obj.spacers.rbtn_height;          % Radio button height

% Calculate heights

b_group_height = 3.*(rbtn_spacer+rbtn_height)+rbtn_spacer; % Discard options button group

panel_height = 5.* btn_spacer + 2.*btn_height + b_group_height;

p.Position(3:4) = [panel_width panel_height];

    % Import data button
    btn = uicontrol(p,'Style','pushbutton');
    btn.String = 'Import Data';

    btn.Units = 'pixels';

    btn_width = 0.9.*panel_width;
    
    btn.Position = [(panel_width-btn_width)./2 panel_height-(2.*btn_spacer+btn_height)  btn_width btn_height];

    % Radio button group for discarding data

    b_group = uibuttongroup(p);
    b_group.Title = 'Discard options';
    b_group.Units = 'pixels';

    b_group_width = 0.9.*panel_width;

    b_group.Position = [(panel_width-b_group_width)./2 btn.Position(2)-(b_group_spacer+b_group_height) b_group_width b_group_height];

        % Radio buttons
       
            rbtn_width = 0.9.*b_group_width;
        
            r1 = uicontrol(b_group,'Style','radiobutton');
            r1.Units = 'pixels';
            r1.String = 'All';
            r1.Position = [(b_group_width - rbtn_width)./2 b_group_height-(rbtn_spacer+rbtn_height) rbtn_width rbtn_height];
            
            r2 = uicontrol(b_group,'Style','radiobutton');
            r2.Units = 'pixels';
            r2.String = 'All but selected';
            r2.Position = [(b_group_width - rbtn_width)./2 b_group_height-2.*(rbtn_spacer+rbtn_height) rbtn_width rbtn_height];
            
            r3 = uicontrol(b_group,'Style','radiobutton');
            r3.Units = 'pixels';
            r3.String = 'Selected';
            r3.Position = [(b_group_width - rbtn_width)./2 b_group_height-3.*(rbtn_spacer+rbtn_height) rbtn_width rbtn_height];
    
    % Discard data button
    btn = uicontrol(p,'Style','pushbutton');
    btn.String = 'Discard Data';

    btn.Units = 'pixels';

    btn_width = 0.9.*panel_width;
    
    btn.Position = [(panel_width-btn_width)./2 b_group.Position(2)-(btn_spacer + btn_height)  btn_width btn_height];  



end

