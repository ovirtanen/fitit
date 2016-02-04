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
sop_height = 8.*checkbox_spacer + 4.*checkbox_height;
panel_height = 3.* checkbox_spacer ... 
               + checkbox_height ...
               + b_group_spacer ...
               + sop_height ...
               + b_group_spacer ...
               + b_group_height ...
               + 2.*btn_spacer ...
               + btn_height;

p.Position(3:4) = [panel_width panel_height];

c1 = uicontrol(p,'Style','checkbox');
c1.Units = 'pixels';
c1.String = 'Batch Fit Autosave';
c1.Callback = @(hObject,callbackdata) obj.update_booleans(hObject,callbackdata);
c1.Position = [(panel_width  - checkbox_width)./2 panel_height-(1.*(checkbox_height)+3.*checkbox_spacer) checkbox_width rbtn_height];
c1.Value = obj.booleans.b_fit_autosave;

s_options_panel = uipanel(p);
s_options_panel.Units = 'pixels';
s_options_panel.Title = 'Save Options';

sop_width = 0.9.*panel_width;
s_options_panel.Position = [(panel_width  - sop_width)./2 c1.Position(2)-(b_group_spacer+sop_height) sop_width sop_height];
    
    c2 = uicontrol(s_options_panel,'Style','checkbox');
    c2.Units = 'pixels';
    c2.String = 'Save as .fitit';
    c2.Callback = @(hObject,callbackdata) obj.update_booleans(hObject,callbackdata);
    c2.Position = [(panel_width  - checkbox_width)./2 sop_height-(3.*checkbox_spacer+checkbox_height) checkbox_width rbtn_height];
    c2.Enable = 'off';
    c2.Value = obj.booleans.save_as_fitit;
    
    
    c3 = uicontrol(s_options_panel,'Style','checkbox');
    c3.Units = 'pixels';
    c3.String = 'Save Loading Seq.';
    c3.Callback = @(hObject,callbackdata) obj.update_booleans(hObject,callbackdata);
    c3.Position = [(panel_width  - checkbox_width)./2 c2.Position(2)-1.*(checkbox_spacer+checkbox_height) checkbox_width rbtn_height];
    c3.Enable = 'off';
    c3.Value = obj.booleans.save_loading_seq;
    
    c4 = uicontrol(s_options_panel,'Style','checkbox');
    c4.Units = 'pixels';
    c4.String = 'Export p to table';
    c4.Callback = @(hObject,callbackdata) obj.update_booleans(hObject,callbackdata);
    c4.Position = [(panel_width  - checkbox_width)./2 c3.Position(2)-1.*(checkbox_spacer+checkbox_height) checkbox_width rbtn_height];
    c4.Value  = obj.booleans.export_p_to_table;
    
    
    c5 = uicontrol(s_options_panel,'Style','checkbox');
    c5.Units = 'pixels';
    c5.String = 'Export as text';
    c5.Callback = @(hObject,callbackdata) obj.update_booleans(hObject,callbackdata);
    c5.Position = [(panel_width  - checkbox_width)./2 c4.Position(2)-1.*(checkbox_spacer+checkbox_height) checkbox_width rbtn_height];
    c5.Value  = obj.booleans.export_as_text;
    
% Radio button group

b_group = uibuttongroup(p);
b_group.Title = 'Save Now';
b_group.Units = 'pixels';
b_group.SelectionChangedFcn = @(hObject,callbackdata) obj.update_booleans(hObject,callbackdata);

b_group_width = 0.9.*panel_width;

b_group.Position = [(panel_width-b_group_width)./2 s_options_panel.Position(2)-(b_group_spacer+b_group_height) b_group_width b_group_height];

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

r_btns = [r1 r2];
f = [obj.booleans.save_now_all,...
     obj.booleans.save_now_selected'];
b_group.SelectedObject = r_btns(f);  

% Set Path push button
btn = uicontrol(p,'Style','pushbutton');
btn.String = 'Set Path';
btn.Tag = 'set_path_btn';
btn.Callback = @(hObject,callbackdata) obj.view.controller.bl_set_path_callback(hObject,callbackdata);
btn.Units = 'pixels';

btn_width = 0.9.*panel_width ./ 2;

btn.Position = [(panel_width-btn_width.*2)./2 b_group.Position(2)-(btn_spacer + btn_height)  btn_width btn_height];

% Save Now push button
btn = uicontrol(p,'Style','pushbutton');
btn.String = 'Save Now';
btn.Tag = 'save_now_btn';
btn.Callback = @(hObject,callbackdata) obj.view.controller.bl_save_now_callback(hObject,callbackdata);
btn.Units = 'pixels';

btn.Position = [(panel_width-btn_width.*2)./2 + btn_width b_group.Position(2)-(btn_spacer + btn_height) btn_width btn_height];
end

