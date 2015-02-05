function quit_callback(obj,hObject,callbackdata)
%QUIT_CALLBACK Deletes Model, View and Controller
%   

close(obj.view.gui);
delete(obj.view);
delete(obj.model);
delete(obj);


end

