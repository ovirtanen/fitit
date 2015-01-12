function save_data_callback(obj)
%SAVE_DATA_CALLBACK Callback for Save data item in the File menu

try 
    
    obj.controller.save_data();
    
catch ME
   
    if strcmp(ME.message,'Save dialog cancelled.')
        
        % do nothing
        
    else rethrow(ME)
        
    end % if
    
end


end

