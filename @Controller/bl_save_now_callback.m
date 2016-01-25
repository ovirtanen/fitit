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
   
    if isempty(obj.model.bl.save_path)
       
        p_path = [pwd '/' datestr(now,30) '-FitIt-p-export.txt'];
        
    else
        
        p_path = [obj.model.bl.save_path '/' datestr(now,30) '-FitIt-p-export.txt'];
        
    end
    
    % Create the p export file.
    
    fid = fopen(p_path,'a');

    if fid == -1

        h = msgbox('Could not open a file for exporting the p table. Check path and directory permissions.','Error');
        return;
        
    else
        
        fclose(fid);

    end
    
    
    % Write parameter names to file
    
    phv = obj.model.construct_p_header_vector(true);
    phv = [{'"Filenames"'}; phv(:)];
    fspec = ['%s' repmat(' %s',[1 numel(phv) - 1]) '\n'];
    
    FileWriter.write_line(p_path,fspec,phv); % opens and closes automagically
    
    for i = 1:numel(nodes)
       
        
       p_file = [nodes(i).total_param_vector(:)'; nodes(i).total_std_vector(:)'];
       p_file = num2cell(p_file(:));
       p_file = [strjoin(nodes(i).filenames,'+'); p_file];

       fspec = ['%s' repmat(' %.3e',[1 numel(p_file) - 1]) '\n'];

       FileWriter.write_line(p_path,fspec,p_file); % opens and closes automagically
        
        
    end
         
end

%% Export full text file
if b.export_as_text
    
    ani = obj.model.bl.active_node_index;
   
    if isempty(obj.model.bl.save_path)
       
        text_path = [pwd '/'];
        
    else
        
        text_path = [obj.model.bl.save_path '/'];
        
    end
    
    
    for i = 1 : numel(nodes)
       
        obj.model.initialize_from_data_node(nodes(i));
        
        path = [text_path datestr(now,30) '-' strjoin(nodes(i).filenames,'+') '-fit.txt'];
               
        obj.save_data(path);
        
    end
    
    % Get original data back if something was shown in the GUI
    if not(isempty(ani))
       
        obj.model.bl.set_active_node(ani);
        obj.model.initialize_from_data_node(obj.model.bl.active_node);
        
    end
    
end
    
end

