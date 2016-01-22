function f_button_callback(obj,hObject,callbackdata)
%F_BUTTON_CALLBACK Callback for the GUI fit button
%
%   f_button_callback(hObject,callbackdata)
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

obj.view.disable_f_button();
prev_state = obj.view.switch_enable_panels('off');
drawnow();

if any(cellfun(@(x)isa(x,'SM_Free_profile'),obj.model.s_models))
    
    options = optimoptions('fmincon');
    options.MaxFunEvals = 5000;
    options.TolX = 1e-7;
    
    p = obj.model.lsq_fit(options);
    
else
    
    p = obj.model.lsq_fit();
    
end

obj.model.set_total_parameter_vector(p);

%% Update Data_node

obj.model.bl.update_data_node_params(obj.model.bl.active_node,true);

%% Update View

obj.view.update_vals_from_model();
obj.view.update_sliders();
obj.view.update_axes();

obj.view.switch_enable_panels(prev_state);
obj.view.update_f_button_status();

if ishghandle(obj.view.bl_view.gui)
    
    obj.view.bl_view.update_table();
    
end

drawnow();

end

