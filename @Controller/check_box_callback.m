function check_box_callback(obj,hObject,callbackdata)
%CHECK_BOX_CALLBACK Callback for parameter fixing checkboxes in FitIt GUI
%  

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

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
        
    case 'br_panel'
        
        target = obj.model.sls_br(str2double(regexp(tag,'\d','match')));
        tag(regexp(tag,'\d')) = [];
        
    otherwise
        
        error('Panel type not recognized');
        
end % switch

target.set_param(tag,v);
obj.view.update_f_button_status();

if not(isempty(obj.view.bl_view.gui)) && ishghandle(obj.view.bl_view.gui)
    
    obj.view.bl_view.update_push_buttons();
    
end

end

