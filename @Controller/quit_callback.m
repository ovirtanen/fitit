function quit_callback(obj,hObject,callbackdata)
%QUIT_CALLBACK Deletes Model, View and Controller
%   

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

sms = obj.model.s_models;
sms = sms(isa(sms,'GPU'));

if not(isempty(sms)) && any(sms.gpu_enabled)
  
    sms(1).device.reset();

end

if not(isempty(obj.view.bl_view.gui)) && ishghandle(obj.view.bl_view.gui)
   
    close(obj.view.bl_view.gui);
    
end


close(obj.view.gui);
delete(obj.view);
delete(obj.model);
delete(obj);


end

