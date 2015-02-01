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
        
            
        target.set_param('bg_val',0);
        target.set_param('bg_chck',1)
            

        for c = 1:numel(controls)
           
            controls(c).Enable = 'off';
            
        end;
        
    case 1
        
            
        val = findobj(panel,'Tag','bg_val');
        target.set_param('bg_val',str2num(val.String));
            
        chck = findobj(panel,'Tag','bg_chck');
        target.set_param('bg_chck',chck.Value);
            
        
        
        for c = 1:numel(controls)
           
            controls(c).Enable = 'on';
            
        end;
    
end % switch

obj.view.update_axes();

end

