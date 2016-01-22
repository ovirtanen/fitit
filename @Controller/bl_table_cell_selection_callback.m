function bl_table_cell_selection_callback(obj)
%BL_TABLE_ CELL_SELECTION_CALLBACK Swaps the currently active Data_node in
%Batch_loader, initializes Model and updates the GUI if single Data_node
%has been selected in Batch_loader GUI

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.


%% Check whether Model data has to be copied to the previous active Data_node

if obj.view.bl_view.booleans.p_update_always && not(isempty(obj.model.bl.active_node))
    
    % previously saved entries
    
    sm_name_node =  obj.model.bl.active_node.s_model_name;
    dist_name_node = obj.model.bl.active_node.dist_name;
    
    p_node = obj.model.bl.active_node.total_param_vector;
    bounds_node = obj.model.bl.active_node.total_param_bounds;
    lb_node = bounds_node(:,1);
    ub_node = bounds_node(:,2);
    p_fixed_node = obj.model.bl.active_node.total_fixed_params;
    
    % Should be the same length
    l_node = max([size(p_node(:),1) size(lb_node(:),1) size(ub_node(:),1) size(p_fixed_node(:),1)]);
    
    % currently loaded entries
    
    sm = obj.model.get_active_s_model();
    
    sm_name =  sm.name;
    dist_name = sm.dist.name;
    
    p = obj.model.get_total_parameter_vector();
    [lb,ub] = obj.model.get_total_param_bounds();
    p_fixed = not(obj.model.get_total_free_params());
    
    l = max([size(p(:),1) size(lb(:),1) size(ub(:),1) size(p_fixed(:),1)]);
     
    if any(not([strcmp(sm_name_node,sm_name),...
            strcmp(dist_name_node,dist_name),...
            l_node == l,...
            all(p_node == p),...
            all(lb_node == lb),...
            all(ub_node == ub),...
            all(p_fixed_node == p_fixed)]))
    
        % Some parametes have been changed
        obj.model.bl.update_data_node_params(obj.model.bl.active_node,false);

    end
    
end

indices = obj.view.bl_view.last_t_indices;

%% Check the indices
if isempty(indices)
    
    obj.view.bl_view.update_push_buttons();
    return;

elseif not(all(indices(:,2) == 1))
   
    % Invalid selection including other than Filename cells.
    obj.view.bl_view.update_push_buttons();
    return;
    
elseif numel(indices) == 2 % One Filename cell has been selected
    
 %% Clean up data 

% Check if already selected node has been selected again, e.g. if the user
% selectes another entry of the multinode.
n_index = obj.view.bl_view.row_indices_to_node_indices(indices);
 
if n_index == obj.model.bl.active_node_index
    
    return;
    
else % if not, proceed with initialization
        
    obj.view.delete_g_sources_in_si_axes();
    obj.model.bl.set_active_node(n_index);
    obj.model.initialize_from_data_node(obj.model.bl.active_node);  % Load data to Model
 
end



%% Initialize g_sources

for i = 1:numel(obj.model.data_sets)
   
    obj.view.initialize_g_sources_for_data_set(obj.model.data_sets(i));
    
end
       
%% update UI

obj.view.swap_panel('sm_panel');
obj.sm_ui_cleanup(obj.model.get_active_s_model().name);
obj.view.swap_panel('dist_panel');
obj.view.swap_panel('bg_panel');

if not(isempty(obj.model.sls_br))
   
    obj.view.swap_panel('br_panel');
    
end

obj.view.update_axes;

obj.view.update_f_button_status();

%% Check for SM_Free_profile
l = findobj(obj.view.menu.tools,'Tag','l_curve');
if any(cellfun(@(x)isa(x,'SM_Free_profile'),obj.model.s_models))
   
    l.Enable = 'on';
    
else
    
    l.Enable = 'off';
    
end

obj.view.bl_view.update_table();
obj.view.bl_view.update_push_buttons();
    
else % Multiple Filename cells have been selected
    
     
    obj.model.bl.set_active_node([]);         % selection is poorly defined, get rid of it.
    obj.view.bl_view.update_push_buttons();
    
    %% Update Views

    obj.view.delete_g_sources_in_si_axes();
    obj.view.initialize_g_source_for_model();
    
end

end

