function br_enable_callback(obj,hObject,callbackdata)
%BR_ENABLE_CALLBACK Callback for enabling a specific SLS_Backreflection
%

% for simplicity, remove all fit related data from nodes in Batch_loader
obj.model.bl.reset_nodes();


tag = hObject.Tag;
id = str2double(tag(8));
state = hObject.Value;

panel = ancestor(hObject,'uipanel');

filter = {panel.Children.Tag};
filter = not(cellfun(@isempty,strfind(filter,num2str(id))));
controls = panel.Children(filter);
% exclude the BG checkbox
controls = controls(not(strcmp(hObject.Tag, {controls.Tag})));

switch state

    case 1

        obj.model.sls_br(id).enable();
        set(controls,'Enable','on');
        
    case 0

        obj.model.sls_br(id).disable();
        set(controls,'Enable','off');
        
end

obj.model.update_handles();
obj.view.update_axes();
obj.view.update_f_button_status();

end

