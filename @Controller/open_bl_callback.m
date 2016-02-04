function open_bl_callback(obj,hObject,callbackdata)
%OPEN_BL_CALLBACK Opens and initializes Batch Loader GUI

if isempty(obj.view.bl_view.gui) || not(ishghandle(obj.view.bl_view.gui))
    
    obj.view.bl_view.initialize_gui();
    
    if not(isempty(obj.model.bl.active_node_index))
    
        %% Transfer parameters

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
    
    %% Remove selections
    
    obj.model.bl.set_active_node([]);         % selection is poorly defined, get rid of it.
    
    % If SAS datasets with smearing were handled before, handles need to be
    % updated as we do not have smearing values for the whole q range of 
    % the plain model. Therefore the smeared expression cannot be
    % calculated.

    obj.model.update_handles();
    
    obj.view.bl_view.update_push_buttons();
    
    %% Update Views
    
    obj.view.bl_view.update_table();
    obj.view.delete_g_sources_in_si_axes();
    obj.view.initialize_g_source_for_model();
    
    % Disable Import data from File menu

    m = findobj(obj.view.menu.file,'Tag','multiple_ds_loader');
    m.Enable = 'off';
    
else
    
   % Make GUI active 
   figure(obj.view.bl_view.gui);

end


end

