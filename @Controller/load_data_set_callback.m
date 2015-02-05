function load_data_set_callback(obj,hObject,callbackdata)
%LOAD_DATA_SET_CALLBACK Callback for loading datasets
%   

ms = [];
switch hObject.Tag;
    
    case 'single_ds_loader'
        
        ms = 'off';
        
    case 'multiple_ds_loader'
        
        ms = 'on';
        
    otherwise
        
        error('Tag not recognized.');
    
end % switch

obj.model.remove_exp_data();

try 
    
    obj.import_data(ms);
    
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
    
end % try-catch

obj.view.update_axes;

obj.view.update_f_button_status();

end


