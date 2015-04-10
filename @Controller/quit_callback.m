function quit_callback(obj,hObject,callbackdata)
%QUIT_CALLBACK Deletes Model, View and Controller
%   

sms = obj.model.s_models;
sms = sms(isa(sms,'GPU'));

if not(isempty(sms)) && any(sms.gpu_enabled)
  
    sms(1).device.reset();

end

close(obj.view.gui);
delete(obj.view);
delete(obj.model);
delete(obj);


end

