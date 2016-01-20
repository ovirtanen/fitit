function bl_discard_data_callback(obj,hObject,callbackdata)
%BL_DISCARD_DATA_CALLBACK Remove specified Data_nodes from Batch_loader

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

indices = obj.view.bl_view.last_t_indices;

if isempty(indices) || not(all(indices(:,2) == 1))
    
    error('Invalid selection.');
    
end

%% Get the Data_node indices 

nn = obj.view.bl_view.row_indices_to_node_indices(indices);

%% Check radio buttons and act accordingly

if obj.view.bl_view.booleans.discard_all
    
    obj.model.bl.remove_data_nodes(1:numel(obj.model.bl.nodes));
    
elseif obj.view.bl_view.booleans.discard_all_but_selected
    
    n = 1:numel(obj.model.bl.nodes);
    n(nn) = [];
    obj.model.bl.remove_data_nodes(n);
    
    if isempty(n) % Discard all but selected but there was only one dataset
        return;
    end
    
elseif obj.view.bl_view.booleans.discard_selected
    
    obj.model.bl.remove_data_nodes(nn);
    
else
    
    error('Error in reading Batch Loader GUI discard radio buttons.');
    
end

%% Discard active node
% Currently there is no way to highlight cell selections in UItable.
% Therefore it is better to remove any data from Model, so that the user
% does not start working with data which might not be the one he or she
% intended. 

obj.model.bl.set_active_node([]);

%% Remove loaded data from Model
obj.model.remove_experimental_data();

%% Adjust Model parameters
obj.model.bg.match_scale_factors_to_ds(1);
obj.model.match_br_to_ds(1);
obj.model.get_active_s_model().match_scale_factors_to_ds(1);

%% Update handles
obj.model.update_handles();

%% Update Views

obj.view.bl_view.set_last_t_indices([]);
obj.view.bl_view.update_table();

obj.view.delete_g_sources_in_si_axes();
obj.view.initialize_g_source_for_model();

%% Update Panels

obj.view.swap_panel('sm_panel');
obj.sm_ui_cleanup(obj.model.get_active_s_model().name);
obj.view.swap_panel('dist_panel');
obj.view.swap_panel('bg_panel');

if not(isempty(obj.model.sls_br))
   
    obj.view.swap_panel('br_panel');
    
end


end

