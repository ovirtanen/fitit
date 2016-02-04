function bl_close_req_callback(obj,hObject,Callbackdata)
%BL_CLOSE_REQ_CALLBACK Callback for closing the Batch Loader GUI
%  

% Copyright (c) 2016, Otto Virtanen
% All rights reserved.


m = findobj(obj.view.menu.file,'Tag','multiple_ds_loader');

% Enable Import data File menu item only if there is maximum one Data_node
% loaded.

nnodes = numel(obj.model.bl.nodes);

if nnodes > 1
    
    m.Enable = 'off';
    
elseif nnodes == 1
    
    m.Enable = 'on';
    
    if isempty(obj.model.bl.active_node)
       
        obj.view.delete_g_sources_in_si_axes();
        obj.model.bl.set_active_node(1);
        obj.model.initialize_from_data_node(obj.model.bl.active_node);
        
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
        
    end
    
elseif nnodes == 0
    
    m.Enable = 'on';

end

delete(hObject);

end

