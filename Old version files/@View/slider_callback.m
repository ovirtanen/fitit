function slider_callback( obj,hObject,inp,tag )
%SLIDER_CALLBACK Callback function for sliders
%
% slider_callback(inp,type,handles)
%
% Parameters:
% hObject   handle to the UI component
% inp       Slider value
% tag       String tag of the UI component
% 
%

obj.controller.set_fit_param(tag,inp);
    
end

