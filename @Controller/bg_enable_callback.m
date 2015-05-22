function bg_enable_callback(obj,hObject,callbackdata)
%BG_ENABLE_CALLBACK Callback for enabling and disabling background
%scattering
%  

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

state = hObject.Value;

panel = ancestor(hObject,'uipanel');

controls = panel.Children;
% exclude the BG checkbox
controls = controls(not(strcmp(hObject.Tag, {controls.Tag})));

target = obj.model.bg;

switch state
    
    case 0
        
        target.toggle_bg('off');              % scattering contribution 0
            
        set(controls,'Enable','off');

        
    case 1
        
        target.toggle_bg('on');              % bg scattering
               
        set(controls,'Enable','on');
        
end % switch

obj.model.update_handles();
obj.view.update_axes();
obj.view.update_f_button_status();

end

