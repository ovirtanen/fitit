function handle_fit_param_events_by_chckbox(obj,src,evnt)
%HANDLE_FIT_PARAM_EVENTS_BY_CHCKBOX Handler for check box events
%   
% handle_fit_param_events_by_chckbox(src,evnt)
%
% Parameters
% obj           Calling View instance
% src           A meta.property object describing the object that is the
%               source of the property event (Model in this case)
% evnt          A Fit_params_fit_data object containing information about the event


handles = guidata(obj.gui);

if not(obj.model.is_data_loaded())
    
    set(handles.calculate_btn,'String','No data loaded');
    set(handles.calculate_btn,'Enable','off');
        
elseif all(obj.model.get_fixed_status())
    
    set(handles.calculate_btn,'String','All values fixed');
    set(handles.calculate_btn,'Enable','off');
    
else    
    set(handles.calculate_btn,'String','Fit');
    set(handles.calculate_btn,'Enable','on');
    
end % if

end

