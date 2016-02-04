function bl_ungroup_to_datasets_callback(obj,hObject,callbackdata)
%BL_UNGROUP_TO_DATASETS_CALLBACK Ungroup a multinode to data_nodes

% Copyright (c) 2015-2016, Otto Virtanen
% All rights reserved.

indices = obj.view.bl_view.last_t_indices;

if isempty(indices) || not(all(indices(:,2) == 1))
    
    error('Invalid selection.');
    
end

%% Get the Data_node indices 

nn = obj.view.bl_view.row_indices_to_node_indices(indices);
unn = unique(nn);

if numel(unn) > 1
   
    % More than one node has been selected
    error('Too many Data_nodes selected');
    
end

%% Check if multinode
node = obj.model.bl.nodes(unn);

if not(node.ismultinode)
   
    error('Data_node is not a multinode.');
    
end

%% Break the node

nodes = Data_node.ungroup(node);

%% Manage nodes

obj.model.bl.remove_data_nodes(unn);
obj.model.bl.add_data_nodes(nodes);

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

