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
        
    elseif strcmp(ME.message,'No numeric data recognized.')
        
        errstr = 'Data file does not seem to contain numeric data.';
    
        errordlg(errstr,'Invalid parameter','modal');
        
    else rethrow(ME)
        
    end % if
    
end % try-catch

switch ms
    
    %case 'on' % add data set if multiselect on
        
    %    obj.model.remove_exp_data();
    %    obj.add_data_set_to_model(d);
        
    case 'off'
        
        ds = obj.model.data_sets; 
        
        if numel(ds) == 1 && all(cellfun(@isempty, {ds.q_exp ds.i_exp ds.std_exp}))
        % Graphics source has to be added
        
            obj.add_data_set_to_model(d);
            
        elseif numel(ds) == 1
        % Graphics source exists, only replace data

            ds.set_experimental_data(d);
            
        else
            
            error('Multiselect not supported');
            % would need to get rid of obsolete Graphics_sources
            % multiple data sets are in the model but only one new data
            % sets is loaded. 
            
            obj.model_remove_exp_data();
            obj.model.data_sets.set_experimental_data(d);
            
        end % if
        
    otherwise
        
        error('Multiselect not supported');
        
end % switch

obj.view.update_axes;

obj.view.update_f_button_status();

end


