function check_box_callback(obj,hObject,callbackdata)
%CHECK_BOX_CALLBACK Callback for parameter fixing checkboxes in FitIt GUI
%  


tag = hObject.Tag;
v = hObject.Value;

panel = ancestor(hObject,'uipanel');

target = [];

switch panel.Tag
    
    case 'bg_panel'
        
        target = obj.model.bg();
        
    case 'sm_panel'
        
        target = obj.model.get_active_s_model();
        
    case 'dist_panel'
        
        sm = obj.model.get_active_s_model();
        target = sm.dist;
        
end % switch

target.set_param(tag,v);


end

