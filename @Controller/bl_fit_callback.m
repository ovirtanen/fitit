function bl_fit_callback(obj,hObject,callbackdata)
%BL_FIT_CALLBACK Callback for the Batch Loader GUI Fit button

% Copyright (c) 2015,2016, Otto Virtanen
% All rights reserved.

b = obj.view.bl_view.booleans;
fms = [b.p_use_original b.p_use_active b.p_propagate];
fit_mode = 0;

%% Retrieve fit mode

if all(fms == [1 0 0])
    
    fit_mode = 1;
    
elseif all(fms == [0 1 0])
    
    fit_mode = 2;
    
elseif all(fms == [0 0 1])
    
    fit_mode = 3;
    
else
    
    error('Corrupted booleans struct.');
    
end

%% Retrieve required nodes

nis = [b.fit_all b.fit_selected];

if all(nis == [1 0])
    
    node_indices = 1:numel(obj.model.bl.nodes);
    
elseif all(nis == [0 1])
    
    node_indices = obj.view.bl_view.last_t_indices;
    
    if isempty(node_indices) || not(all(node_indices(:,2) == 1))
       
        error('Illegal selection.');
        
    end
    
    node_indices = obj.view.bl_view.row_indices_to_node_indices(node_indices);
    
else
    
    error('Corrupted booleans struct.');
    
end

%% Update the current node in the case the user has changed the parameters

if not(isempty(obj.model.bl.active_node))

    obj.model.bl.update_data_node_params(obj.model.bl.active_node);

end

%% Get current active node

current_active_node = obj.model.bl.active_node_index;


%% Switch off controls

prev_state = obj.view.switch_enable_panels('off');
obj.view.disable_f_button();
blv_prev_state = obj.view.bl_view.switch_enable_panels('off');


%% Fit nodes

wb = waitbar(0,'Batch fitting...');
wb.WindowStyle = 'modal';
%wb.CloseRequestFcn = @(src,callbackdata) beep();
drawnow();

obj.multi_lsq_fit(node_indices,fit_mode,@(x)wbar(wb,x)); % see wbar below

wb.delete();

%% Update View

if isempty(current_active_node) % delete everything

    obj.view.delete_g_sources_in_si_axes();
    obj.view.initialize_g_source_for_model();

else
    
    obj.view.delete_g_sources_in_si_axes();
    obj.model.bl.set_active_node(current_active_node);
    obj.model.initialize_from_data_node(obj.model.bl.active_node);  % Load data to Model
    
    % Initialize g_sources

    for i = 1:numel(obj.model.data_sets)

        obj.view.initialize_g_sources_for_data_set(obj.model.data_sets(i));

    end
    
    obj.view.update_vals_from_model();
    obj.view.update_sliders();
    obj.view.update_axes();

    obj.view.update_f_button_status();
    drawnow();
    
end

obj.view.bl_view.update_table();
obj.view.switch_enable_panels(prev_state);
obj.view.update_f_button_status();
obj.view.bl_view.switch_enable_panels(blv_prev_state);

end

function wbar(wb,frac)
       
waitbar(frac,wb);
        
 end
