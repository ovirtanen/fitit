function save_data_callback(obj,hObject,callbackdata)
%SAVE_DATA_CALLBACK Callback for the save menu

try 
    
    obj.save_data();
    
catch ME
   
    if strcmp(ME.message,'Save dialog cancelled.')
        
        % do nothing
        
    else rethrow(ME)
        
    end % if
    
end



end

