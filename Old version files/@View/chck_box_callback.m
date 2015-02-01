function chck_box_callback(obj,inp,tag)
%CHCK_BOX_CALLBACK Callback function for "fixed" check boxes
%
% chck_box_callback(hObject,inp,tag)
%
% Parameters:
% hObject   handle to the UI component
% inp       User input string
% tag       String tag of the UI component
%

obj.controller.set_fit_param(tag,inp);

end

