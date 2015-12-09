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

panel_height = 7.* btn_spacer + 4.*btn_height + b_group_height;

p.Position(3:4) = [panel_width panel_height];

% Import Data push button
id_btn = uicontrol(p,'Style','pushbutton');
id_btn.String = 'Import Data';
id_btn.Callback = @(hObject,callbackdata) obj.view.controller.bl_batch_load_callback(hObject,callbackdata);
id_btn.Tag = 'import_data_btn';

id_btn.Units = 'pixels';

btn_width = 0.9.*panel_width;

id_btn.Position = [(panel_width-btn_width)./2 panel_height-(2.*btn_spacer+btn_height)  btn_width btn_height];

% Group to Multiset push button

gm_btn = uicontrol(p,'Style','pushbutton');
gm_btn.String = 'Group to Multiset';
gm_btn.Callback = @(hObject,callbackdata) obj.view.controller.bl_group_to_multiset_callback(hObject,callbackdata);
gm_btn.Tag = 'group_to_multiset_btn';

gm_btn.Units = 'pixels';

gm_btn.Position = [(panel_width-btn_width)./2 id_btn.Position(2)-(1*btn_spacer+btn_height)  btn_width btn_height];

% Ungroup to datasets push button

ug_btn = uicontrol(p,'Style','pushbutton');
ug_btn.String = 'Unroup to Datasets';
ug_btn.Tag = 'ungroup_to_datasets_btn';

ug_btn.Units = 'pixels';

ug_btn.Position = [(panel_width-btn_width)./2 gm_btn.Position(2)-(1*btn_spacer+btn_height)  btn_width btn_height];

% Radio button group for discarding data

b_group = uibuttongroup(p);
b_group.Title = 'Discard Options';
b_group.Units = 'pixels';
b_group.SelectionChangedFcn = @(hObject,callbackdata) obj.update_booleans(hObject,callbackdata);

b_group_width = 0.9.*panel_width;

b_group.Position = [(panel_width-b_group_width)./2 ug_btn.Position(2)-(b_group_spacer+b_group_height) b_group_width b_group_height];

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

r_btns = [r1 r2 r3];
f = [obj.booleans.discard_all obj.booleans.discard_all_but_selected obj.booleans.discard_selected];
b_group.SelectedObject = r_btns(f);        

% Discard data button
id_btn = uicontrol(p,'Style','pushbutton');
id_btn.String = 'Discard Data';
id_btn.Tag = 'discard_data_btn';
id_btn.Callback = @(hObject,callbackdata) obj.view.controller.bl_discard_data_callback(hObject,callbackdata);

id_btn.Units = 'pixels';

btn_width = 0.9.*panel_width;

id_btn.Position = [(panel_width-btn_width)./2 b_group.Position(2)-(btn_spacer + btn_height)  btn_width btn_height];  



end

