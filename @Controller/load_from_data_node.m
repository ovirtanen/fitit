function load_from_data_node(obj,dn)
%LOAD_FROM_DATA_NODE Loads data from a Data_node instance and updates the
%GUI
%
%   load_from_data_node(dn)
%
% Parameters
% dn            Data_node instance
%

Lib.inargtchck(dn,@(x)isa(x,'Data_node'));

%% Clean up data 

obj.view.delete_g_sources_in_si_axes();

obj.model.initialize_from_data_node(dn);

%% Initialize g_sources

for i = 1:numel(obj.model.data_sets)
   
    obj.view.initialize_g_sources_for_data_set(obj.model.data_sets(i));
    
end
       
%% update UI

obj.view.swap_panel('sm_panel');
obj.sm_ui_cleanup(obj.model.get_active_s_model().name);
obj.view.swap_panel('dist_panel');
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

