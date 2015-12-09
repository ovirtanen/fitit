function bl_group_to_multiset_callback(obj,hObject,callbackdata)
%BL_GROUP_TO_MUTLISET_CALLBACK Group individual Data_nodes to a multiset


% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

indices = obj.view.bl_view.last_t_indices

if isempty(indices) || not(all(indices(:,2) == 1)) || numel(indices(:,1)) < 2
    
    error('Invalid selection.');
    
end

%% Get the Data_node indices 

nn = obj.view.bl_view.row_indices_to_node_indices(indices);

%% Create Multinode
nodes = obj.model.bl.nodes(nn);
nodes = num2cell(nodes);

multinode = Data_node.combine(nodes{:});

%% Manage nodes

obj.model.bl.remove_data_nodes(nn);
obj.model.bl.add_data_nodes(multinode);

%% Discard active node
% Currently there is no way to highlight cell selections in UItable.
% Therefore it is better to remove any data from Model, so that the user
% does not start working with data which might not be the one he or she
% intended. 

obj.model.bl.set_active_node([]);

%% Update Views

obj.view.bl_view.set_last_t_indices([]);
obj.view.bl_view.update_table();

obj.view.delete_g_sources_in_si_axes();
obj.view.initialize_g_source_for_model();

end

