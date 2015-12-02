function bl_swap_active_data_node_callback(obj)
%BL_SWAP_ACTIVE_DATA_NODE_CALLBACK Swaps the currently active Data_node in
%Batch_loader, initializes Model and updates the GUI if single Data_node
%has been selected in Batch_loader GUI

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

indices = obj.view.bl_view.last_t_indices;

if not(numel(indices)==2 && indices(2) == 1)
   
    % Invalid selection, do nothing and return.
    return;
    
end

%% Clean up data 

obj.view.delete_g_sources_in_si_axes();
obj.model.bl.set_active_node(indices(1));
obj.model.initialize_from_data_node(obj.model.bl.active_node);  % Load data to Model


%% Initialize g_sources

for i = 1:numel(obj.model.data_sets)
   
    obj.view.initialize_g_sources_for_data_set(obj.model.data_sets(i));
    
end
       
%% update UI

obj.view.swap_panel('sm_panel');
obj.sm_ui_cleanup(obj.model.get_active_s_model().name);
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
end

