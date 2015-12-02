function initialize_gui(obj)
%INITIALIZE_GUI Initializes figure holding the Batch_loader GUI
%   
% fig = initialize_gui()
%
% Returns
% fig       Figure with GUI elements
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

%% Build the root figure

fig = figure('Name','FitIt! Batch Loader','Visible','off'); % Change Visible to off 
fig.Tag = 'Root';
fig.NumberTitle = 'off';
fig.ToolBar = 'none';
fig.MenuBar = 'none';

fig.Units = 'pixels';
fig.Position = [22  271 720  630]; %[left bottom width height]
fig.Resize = 'off';

obj.gui = fig;

%% Initialize the uitable for data browsing

t = uitable(fig);
t.Units = 'pixels';
%t.Interruptible = 'off';
%t.BusyAction = 'cancel';
t.CellSelectionCallback = @(hObject,callbackdata) obj.view.controller.bl_table_cell_callback(hObject,callbackdata,obj);

t_width = 650;
t_height = 270;
t_spacer = 20;

t.Position = [(fig.Position(3)-t_width)./2 fig.Position(4)-(t_height+t_spacer) t_width t_height]; %[left bottom width height]

cnames = {'Filename','Fit','Saved'};
t.ColumnName = cnames;

% Get any data that might be in the Model

d = Batch_loader.data_nodes_to_table(obj.view.model.bl.nodes);
t.Data = d;

% Check the width of the darn box

small_column_width = 50;
extra_spacer = 50;          % Works on my Mac.

width = t.Position(3);
t.ColumnWidth = {width - 2.* small_column_width-extra_spacer, small_column_width,small_column_width};

obj.file_table = t;

%% Initialize UIPanels

available_width = t.Position(3);
panel_spacer = obj.spacers.panel_spacer;
panel_width = (available_width - 3.*panel_spacer )./4;


% Manage Data panel -------------------------------------------------------

obj.manage_panel = obj.initialize_manage_panel(panel_width);
m_panel_height = obj.manage_panel.Position(4);

obj.manage_panel.Position(1:2) = [t.Position(1) (t.Position(2)-panel_spacer-m_panel_height)];

% Parameter update panel --------------------------------------------------

obj.pupdate_panel = obj.initialize_pupdate_panel(panel_width);
pu_panel_height = obj.pupdate_panel.Position(4);

obj.pupdate_panel.Position(1:2) = [t.Position(1)+(panel_spacer+panel_width) t.Position(2)-panel_spacer-pu_panel_height];


% Batch fit panel ---------------------------------------------------------

obj.bfit_panel = obj.initialize_bfit_panel(panel_width);
bfit_panel_height = obj.bfit_panel.Position(4);

obj.bfit_panel.Position(1:2) = [t.Position(1)+2.*(panel_spacer+panel_width) t.Position(2)-(panel_spacer+bfit_panel_height)];

% Save fit panel ---------------------------------------------------------

obj.save_panel = obj.initialize_save_panel(panel_width);
save_panel_height = obj.save_panel.Position(4);

obj.save_panel.Position(1:2) = [t.Position(1)+3.*(panel_spacer+panel_width) t.Position(2)-panel_spacer-save_panel_height];

% fig.Position(4) = t_spacer + t_height + t_spacer + max([p_data.Position(4) p_policy.Position(4) p_batch.Position(4) p_save.Position(4)]) + t_spacer;

fig.Visible = 'on';

end

