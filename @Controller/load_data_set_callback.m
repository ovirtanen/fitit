function load_data_set_callback(obj,hObject,callbackdata)
%LOAD_DATA_SET_CALLBACK Callback for loading datasets
%   

ms = [];
switch hObject.Tag;
    
    case 'single_ds_loader'
        
        ms = 'off';
        
    case 'multiple_ds_loader'
        
        error('Multiple loading is not supported yet.');
        %ms = 'on';
        
    otherwise
        
        error('Tag not recognized/supported.');
    
end % switch

try 
    
    d = obj.import_data(ms); % d contains only one data set for now
    
catch ME
   
    if strcmp(ME.message,'Open dialog cancelled.')
        
        return;
        
    elseif strcmp(ME.message,'Data structure not recognized.')
        
        errstr = 'Data file does not seem to have three columns. There should be only three columns: q(nm^(-1)), intensity and std.';
    
        errordlg(errstr,'Invalid parameter','modal');
        
        return;
        
    elseif strcmp(ME.message,'No numeric data recognized.')
        
        errstr = 'Data file does not seem to contain numeric data.';
    
        errordlg(errstr,'Invalid parameter','modal');
        
        return;
        
    else rethrow(ME)
        
    end % if
    
end % try-catch

switch ms
    
    %case 'on' % add data set if multiselect on
        
    %    obj.model.remove_exp_data();
    %    obj.add_data_set_to_model(d);
        
    case 'off'
        
       obj.view.delete_g_sources_in_si_axes();
       obj.model.remove_experimental_data();
       obj.add_data_set_to_model(d); 
       
    otherwise
        
        error('Data loading error.');
        
end % switch

obj.view.update_axes;

obj.view.update_f_button_status();

end


