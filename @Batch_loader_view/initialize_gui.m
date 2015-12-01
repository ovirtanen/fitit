function fig = initialize_gui(obj)
%INITIALIZE_GUI Initializes figure holding the Batch_loader GUI
%   
% fig = initialize_gui()
%
% Returns
% fig       Figure with GUI elements
%

%% Build the root figure

fig = figure('Name','FitIt! Batch Loader','Visible','on'); % Change Visible to off 
fig.Tag = 'Root';
fig.NumberTitle = 'off';
fig.ToolBar = 'none';
fig.MenuBar = 'none';

fig.Units = 'pixels';
fig.Position = [22  271 720  570]; %[left bottom width height]
fig.Resize = 'off';

obj.gui = fig;

%% Initialize the uitable for data browsing

t = uitable(fig);
t.Units = 'pixels';

t_width = 650;
t_height = 270;
t_spacer = 20;

t.Position = [(fig.Position(3)-t_width)./2 fig.Position(4)-(t_height+t_spacer) t_width t_height]; %[left bottom width height]

cnames = {'Filename','Fit','Saved'};
t.ColumnName = cnames;

d = rand(50,3);
t.Data = d;

% Check the width of the darn box

small_column_width = 50;
extra_spacer = 50;          % Works on my Mac.

width = t.Position(3);
t.ColumnWidth = {width - 2.* small_column_width-extra_spacer, small_column_width,small_column_width};

%% Initialize UIPanels

available_width = t.Position(3);
panel_spacer = 10;
panel_width = (available_width - 3.*panel_spacer )./4;


% Manage Data panel -------------------------------------------------------
p_data = uipanel(fig);
obj.manage_panel = p_data;
p_data.Title = 'Manage data';
p_data.Units
p_data.Units = 'pixels';

% Spacers & heights

btn_spacer = 15;        % Push button spacer
rbtn_spacer = 15;       % Radio button spacer
b_group_spacer = 15;    % Radio button group spacer

btn_height = 30;        % Push button height
rbtn_height = 20;       % Radio button height
bgroup_height = 3.*(rbtn_spacer+rbtn_height)+rbtn_spacer;

panel_height = 4.* btn_spacer + 2.*btn_height + bgroup_height;

p_data.Position = [t.Position(1) t.Position(2)-panel_spacer-panel_height panel_width panel_height];

    % Import data button
    btn = uicontrol(p_data,'Style','pushbutton');
    btn.String = 'Import Data';

    btn.Units = 'pixels';

    btn_width = 0.9.*p_data.Position(3);
    
    btn.Position = [(p_data.Position(3)-btn_width)./2 p_data.Position(4)-(btn_spacer+btn_height)  btn_width btn_height];

        % Pushbutton group for discarding data

        bgroup = uibuttongroup(p_data);
        bgroup.Title = 'Discard options';
        bgroup.Units = 'pixels';
        
        bgroup_width = 0.9.*p_data.Position(3);

        bgroup.Position = [(p_data.Position(3)-bgroup_width)./2 btn.Position(2)-(b_group_spacer+bgroup_height) bgroup_width bgroup_height];

        % Pushbuttons
       
            rbtn_width = 0.9.*bgroup_width;
        
            r1 = uicontrol(bgroup,'Style','radiobutton');
            r1.Units = 'pixels';
            r1.String = 'All';
            r1.Position = [(bgroup_width - rbtn_width)./2 bgroup_height-(rbtn_spacer+rbtn_height) rbtn_width rbtn_height];
            
            r2 = uicontrol(bgroup,'Style','radiobutton');
            r2.Units = 'pixels';
            r2.String = 'All but selected';
            r2.Position = [(bgroup_width - rbtn_width)./2 bgroup_height-2.*(rbtn_spacer+rbtn_height) rbtn_width rbtn_height];
            
            r3 = uicontrol(bgroup,'Style','radiobutton');
            r3.Units = 'pixels';
            r3.String = 'Selected';
            r3.Position = [(bgroup_width - rbtn_width)./2 bgroup_height-3.*(rbtn_spacer+rbtn_height) rbtn_width rbtn_height];
    
    % Discard data button
    btn = uicontrol(p_data,'Style','pushbutton');
    btn.String = 'Discard Data';

    btn.Units = 'pixels';

    btn_width = 0.9.*p_data.Position(3);
    
    btn.Position = [(p_data.Position(3)-btn_width)./2 btn_spacer  btn_width btn_height];       

% Parameter policy panel --------------------------------------------------
p_policy = uipanel(fig);
p_policy.Title = 'Parameter update policy';
p_policy.Position = [t.Position(1)+(panel_spacer+panel_width) t.Position(2)-panel_spacer-panel_height panel_width panel_height];

p_batch = uipanel(fig);
p_batch.Title = 'Batch fitting';
p_batch.Position = [t.Position(1)+2.*(panel_spacer+panel_width) t.Position(2)-panel_spacer-panel_height panel_width panel_height];

p_save = uipanel(fig);
p_save.Title = 'Saving';
p_save.Position = [t.Position(1)+3.*(panel_spacer+panel_width) t.Position(2)-panel_spacer-panel_height panel_width panel_height];


% fig.Position(4) = t_spacer + t_height + t_spacer + max([p_data.Position(4) p_policy.Position(4) p_batch.Position(4) p_save.Position(4)]) + t_spacer;


end

