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

%% Clean up data & load

obj.view.delete_g_sources_in_si_axes();

if not(isempty(obj.model.bl.nodes)) % previous data loaded, no need to reinitialize the whole GUI
    
    obj.model.bl.batch_load_data(d,p);
    obj.view.bl_view.update_table();
    
else
    
    obj.model.bl.batch_load_data(d,p);
    
end

obj.view.bl_view.update_table();
obj.view.bl_view.set_last_t_indices([]);
obj.model.bl.set_active_node([]);

%% Initialize g_source
% Currently there is no way to highlight cell selections in UItable.
% Therefore it is better to remove any data from Model, so that the user
% does not start working with data which might not be the one he or she
% intended. 

obj.view.initialize_g_source_for_model();

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

