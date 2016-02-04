function bg_enable_callback(obj,hObject,callbackdata)
%BG_ENABLE_CALLBACK Callback for enabling and disabling background
%scattering
%  

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

obj.model.bl.reset_nodes();

state = hObject.Value;
nbg = str2double(hObject.Tag(8));
panel = ancestor(hObject,'uipanel');

controls = panel.Children(1:end-3);
controls = reshape(controls,[6 numel(controls)./6]);
controls = controls(:,size(controls,2)+1-nbg);
% exclude the BG checkbox
controls = controls(not(strcmp(hObject.Tag, {controls.Tag})));

target = obj.model.bg;


switch state
    
    case 0
        
        target.toggle_bg(nbg,'off');              % bg scattering off
            
        set(controls,'Enable','off');

        
    case 1
        
        target.toggle_bg(nbg,'on');              % bg scattering
               
        set(controls,'Enable','on');
        
end % switch

obj.model.update_handles();
obj.view.update_axes();
obj.view.update_f_button_status();

end

