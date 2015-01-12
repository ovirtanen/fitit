function import_data_callback(obj)
%IMPORT_DATA_CALLBACK Callback for Import data File menu item

try 
    
    obj.controller.import_data();
    
catch ME
   
    if strcmp(ME.message,'Open dialog cancelled.')
        
        % do nothing
        
    elseif strcmp(ME.message,'Data structure not recognized.')
        
        errstr = 'Data file does not seem to have three columns. There should be only three columns: q(nm^(-1)), intensity and std.';
    
        errordlg(errstr,'Invalid parameter','modal');
        
    elseif strcmp(ME.message,'No numeric data recognized.')
        
        errstr = 'Data file does not seem to contain numeric data.';
    
        errordlg(errstr,'Invalid parameter','modal');
        
    else rethrow(ME)
        
    end % if
    
end


end

