function edit_box_callback(obj,hObject,inp,tag,type)
%EDIT_BOX_CALLBACK Callback function for editable text box containing
%parameters
%   Checks the validity of the input and tells controller to update Model.
%
% edit_box_callback(inp,type,handles)
%
% Parameters:
% hObject   handle to the UI component
% inp       User input string
% tag       String tag of the UI component
% type      Edit box type, 'min', 'val' or 'max'
%

if obj.ui_limits_check(inp,type,tag) 
   
    obj.controller.set_fit_param(tag,inp);
    
else
    
    old_value = obj.controller.model.get_fit_param(tag);
    set(hObject,'String',old_value);
    
    errstr = 'Parameters have to be numeric, at least 0 and respect the limits imposed by other fields.';
    
    errordlg(errstr,'Invalid parameter','modal');
      
end % if

end

