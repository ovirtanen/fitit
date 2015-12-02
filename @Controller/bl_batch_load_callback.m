function bl_batch_load_callback(obj,hObject,callbackdata)
%BATCH_LOAD_CALLBACK Callback for batch loading data


% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

try 
    
    [d,p] = obj.import_data('on');     % multi-select on
    
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

%% Data exist, only load additional data

if not(isempty(obj.model.bl.active_node)) % previous data loaded, no need to reinitialize the whole GUI
    
    obj.model.bl.batch_load_data(d,p);
    obj.view.bl_view.update_table();
    return;
    
end

%% Clean up data & load

obj.view.delete_g_sources_in_si_axes();
obj.model.bl.batch_load_data(d,p);
obj.view.bl_view.update_table();
obj.model.initialize_from_data_node(obj.model.bl.active_node);  % Load data to Model


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


end

