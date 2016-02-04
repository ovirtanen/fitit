function load_data_set_callback(obj,hObject,callbackdata)
%LOAD_DATA_SET_CALLBACK Callback for loading datasets
%   

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.


%% Import the raw data

ms = [];
switch hObject.Tag;
    
    case 'single_ds_loader'
        
        ms = 'off';
        
    case 'multiple_ds_loader'
        
        ms = 'on';
        
    otherwise
        
        error('Tag not recognized/supported.');
    
end % switch

try 
    
    [d,fn] = obj.import_data(ms);
    
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

%% Clean up data 

obj.view.delete_g_sources_in_si_axes();

%obj.model.initialize_from_data(d);

qcf = obj.import_q_conversion_factor(obj.fr.last_filter_spec_index);
obj.model.bl.single_load_data(d,fn,qcf); % Create Data_node to Batch_loader

% SLS backreflection and SAS smearing cannot be enabled at the same time.
if not(isempty(obj.model.sls_br)) && any([obj.model.bl.active_node.data_sets.is_smeared])
        
    obj.model.remove_sls_backreflection();
    
end

obj.model.initialize_from_data_node(obj.model.bl.active_node);  % Load data to Model (update_handles)

%% Initialize g_sources

for i = 1:numel(obj.model.data_sets)
   
    obj.view.initialize_g_sources_for_data_set(obj.model.data_sets(i));
    
end
       
%% update UI

obj.view.swap_panel('sm_panel');
obj.sm_ui_cleanup(obj.model.get_active_s_model().name);
obj.view.swap_panel('bg_panel');

if not(isempty(obj.model.sls_br))
   
    obj.view.swap_panel('br_panel');
    
end


obj.view.update_axes;

obj.view.update_f_button_status();

%% Check for SM_Free_profile
l = findobj(obj.view.menu.tools,'Tag','l_curve');
if any(cellfun(@(x)isa(x,'SM_Free_profile'),obj.model.s_models))
   
    l.Enable = 'on';
    
else
    
    l.Enable = 'off';
    
end

%% Check for SAS smearing

l = findobj(obj.view.menu.tools,'Tag','br_switch');
if any([obj.model.data_sets.is_smeared])
   
    l.Enable = 'off';
    
    if not(isempty(obj.view.br_panel))
       
       l.Label = 'Enable SLS Backreflection';
       obj.view.delete_br_panel(); 
       obj.view.update_axes();
       
    end
    
else
    
    l.Enable = 'on';
    
end

end




