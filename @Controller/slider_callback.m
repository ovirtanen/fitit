function slider_callback(obj,hObject,callbackdata)
%SLIDER_CALLBACK Callback for parameter sliders in FitIt GUI
%   

tag = hObject.Tag;
id = tag(1:end-5);
panel = ancestor(hObject,'uipanel');
value = hObject.Value;

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

target.set_param([id '_val'],value);

eb_val = findobj(panel.Children,'Tag',[id '_val']);
eb_val.String = num2str(value);

obj.view.update_axes();

end

