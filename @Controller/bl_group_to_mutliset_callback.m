function bl_group_to_mutliset_callback(obj,hObject,callbackdata)
%BL_GROUP_TO_MUTLISET_CALLBACK Group individual Data_nodes to a multiset


% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

indices = obj.view.bl_view.last_t_indices;

if isempty(indices) || not(all(indices(:,2) == 1)) || numel(indices(:,1) < 2)
    
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

% Sort just to be sure
fns = [obj.nodes.filenames];
[~,order] = sort(fns);
obj.nodes = obj.nodes(order);

end

