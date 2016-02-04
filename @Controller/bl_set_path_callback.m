function bl_set_path_callback(obj, hObject, callbackdata)
%BL_SET_PATH_CALLBACK Callback for the Set Path button in Batch Loader GUI.

path = uigetdir(obj.fr.last_load_path);

if path == 0        % user cancelled the dialog.
    
    return;
    
else
   
    try
        
        obj.model.bl.set_save_path(path);
        
    catch ME
        
        if strcmp(ME.identifier,'SET_SAVE_PATH:Bad_directory');
            
            h = msgbox('Invalid directory: Cannot read or write.','Invalid path');
            
        else
           
            rethrow(ME);
            
        end % if
        
    end % try-catch
    
end % if

end

