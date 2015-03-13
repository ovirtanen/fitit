function f_button_callback(obj,hObject,callbackdata)
%F_BUTTON_CALLBACK Callback for the GUI fit button
%
%   f_button_callback(hObject,callbackdata)
%

obj.view.disable_f_button();
obj.view.disable_panels();
drawnow();

%profile clear;
%profile on;
p = obj.model.lsq_fit();
%profile off;

obj.model.set_total_parameter_vector(p);
obj.view.update_vals_from_model();
obj.view.update_sliders();
obj.view.update_axes();

obj.view.enable_panels();
obj.view.update_f_button_status();

end

