function bg_enable_callback(obj,hObject,callbackdata)
%BG_ENABLE_CALLBACK Callback for enabling and disabling background
%scattering
%  

state = hObject.Value;

panel = ancestor(hObject,'uipanel');

controls = panel.Children;
% exclude the BG checkbox
controls = controls(not(strcmp(hObject.Tag, {controls.Tag})));

target = obj.model.bg;

switch state
    
    case 0
        
        target.toggle_bg('off');              % scattering contribution 0
        target.set_param('bg_chck',1)
            
        set(controls,'Enable','off');

        
    case 1
        
        target.toggle_bg('on');              % bg scattering
        
        % update fixed status for the bg
        chck = findobj(panel,'Tag','bg_chck');
        target.set_param('bg_chck',chck.Value);
            
        
        set(controls,'Enable','on');
        
end % switch

obj.view.update_axes();
obj.view.update_f_button_status();

end

