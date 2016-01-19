function p = initialize_bfit_panel(obj,panel_width)
%INITIALIZE_BFIT_PANEL Initialize Batch fit -panel
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
p.Title = 'Batch fitting';

% Spacers and heights

rbtn_spacer = obj.spacers.rbtn_spacer;          % Radio button spacer
rbtn_height = obj.spacers.rbtn_height;          % Radio button height
b_group_spacer = obj.spacers.b_group_spacer;    % Radio button group spacer
btn_spacer = obj.spacers.btn_spacer;            % Push button spacer
btn_height = obj.spacers.btn_height;            % Push button spacer

% Calculate size parameters

fitgroup_height = 2.*(rbtn_spacer+rbtn_height)+rbtn_spacer;
fitoptions_height = 3.*(rbtn_spacer+rbtn_height)+rbtn_spacer;

panel_height = fitgroup_height + fitoptions_height +2.* b_group_spacer + 3.* btn_spacer + btn_height;

p.Position(3:4) = [panel_width panel_height];

% Pushbutton group for choosing data for fitting

b_group = uibuttongroup(p);
b_group.Title = 'Fit';
b_group.Units = 'pixels';
b_group.SelectionChangedFcn = @(hObject,callbackdata) obj.update_booleans(hObject,callbackdata);

b_group_width = 0.9.*panel_width;


b_group.Position = [(panel_width-b_group_width)./2 b_group.Position(4)-(b_group_spacer+fitgroup_height) b_group_width fitgroup_height];

% Pushbuttons

    rbtn_width = 0.9.*b_group_width;

    r1 = uicontrol(b_group,'Style','radiobutton');
    r1.Units = 'pixels';
    r1.String = 'All';
    r1.Position = [(b_group_width - rbtn_width)./2 fitgroup_height-(rbtn_spacer+rbtn_height) rbtn_width rbtn_height];

    r2 = uicontrol(b_group,'Style','radiobutton');
    r2.Units = 'pixels';
    r2.String = 'Only selected';
    r2.Position = [(b_group_width - rbtn_width)./2 fitgroup_height-2.*(rbtn_spacer+rbtn_height) rbtn_width rbtn_height];

r_btns = [r1 r2];
f = [obj.booleans.fit_all,...
     obj.booleans.fit_selected];
b_group.SelectedObject = r_btns(f);  

% Radio button group for selecting fitting mode

b_group = uibuttongroup(p);
b_group.Title = 'Initial Guess Vector p';
b_group.Units = 'pixels';
b_group.SelectionChangedFcn = @(hObject,callbackdata) obj.update_booleans(hObject,callbackdata);

b_group.Position = [(p.Position(3)-b_group_width)./2 b_group.Position(4)-(2.*b_group_spacer+fitgroup_height+fitoptions_height) b_group_width fitoptions_height];

% Radio buttons

    rbtn_width = 0.9.*b_group_width;

    r1 = uicontrol(b_group,'Style','radiobutton');
    r1.Units = 'pixels';
    r1.String = 'Use original p';
    r1.Position = [(b_group_width - rbtn_width)./2 fitoptions_height-(rbtn_spacer+rbtn_height) rbtn_width rbtn_height];

    r2 = uicontrol(b_group,'Style','radiobutton');
    r2.Units = 'pixels';
    r2.String = 'Use active p';
    r2.Position = [(b_group_width - rbtn_width)./2 fitoptions_height-2.*(rbtn_spacer+rbtn_height) rbtn_width rbtn_height];

    r3 = uicontrol(b_group,'Style','radiobutton');
    r3.Units = 'pixels';
    r3.String = 'Propagate active p';
    r3.Position = [(b_group_width - rbtn_width)./2 fitoptions_height-3.*(rbtn_spacer+rbtn_height) rbtn_width rbtn_height];

r_btns = [r1 r2 r3];
f = [obj.booleans.p_use_original,...
     obj.booleans.p_use_active,...
     obj.booleans.p_propagate];
b_group.SelectedObject = r_btns(f);  

% Fit data button
btn = uicontrol(p,'Style','pushbutton');
btn.String = 'Fit';
btn.Tag = 'fit_btn';
btn.Callback = @(hObject,callbackdata) obj.view.controller.bl_fit_callback(hObject,callbackdata);

btn.Units = 'pixels';

btn_width = 0.9.*panel_width;

btn.Position = [(panel_width-btn_width)./2 b_group.Position(2)-(btn_spacer+btn_height)  btn_width btn_height];


end

