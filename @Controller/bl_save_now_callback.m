function bl_save_now_callback(obj,hObject,callbackdata)
%BL_SAVE_NOW_CALLBACK Callback for Batch Loader GUI's Save Now pushbutton


% Copyright (c) 2016, Otto Virtanen
% All rights reserved.

b = obj.view.bl_view.booleans;

%% Initial checks

if numel(obj.model.bl.nodes) == 0
    
    h = msgbox('No data loaded.','Error');
    return;
    
elseif not(any([b.save_as_fitit b.save_loading_seq b.export_p_to_table b.export_as_text]))

    h = msgbox('No save options selected.','Error');
    return;
    
end

%% Check nodes

nodes = [];

if b.save_now_selected
    
    indices = obj.view.bl_view.last_t_indices;
    indices = obj.view.bl_view.row_indices_to_node_indices(indices);
    
    nodes = obj.model.bl.nodes(indices);
    
elseif b.save_now_all

    nodes = obj.model.bl.nodes();
    
else
    
    error('Invalid boolean struct in Batch_loader_view.');
    return;
    
end

if numel(nodes) == 0
   
    h = msgbox('Invalid selection.','Error');
    return;
    
elseif b.export_p_to_table && not(all([nodes.isfit]))
    
    h = msgbox('Export p to table has been selected but not all the selected nodes have been fit.','Error');
    return;
    
end

%% p table export

if b.export_p_to_table
   
    obj.p_table_export(nodes);
    
end

%% Export full text file
if b.export_as_text
    
    obj.text_file_export(nodes);
  
end
    
end

