function handle_all_fit_params_changed(obj,src,evnt)
%HANDLE_ALL_FIT_PARAMS_CHANGED Handler for all_fit_params_changed
%  
% handle_all_fit_params_changed(src,evnt) updates edit box texts, slider
% positions and axes.
% 
% Parameters
% obj           Calling View instance
% src           A meta.property object describing the object that is the
%               source of the property event (Model in this case)
% evnt          A Fit_params_fit_data object containing information about the event

handles = guidata(obj.gui);

k = keys(obj.model.param_map);
vals = k(~cellfun(@isempty,strfind(k,'_val'))); % get all value parameters '_val'

for v = vals
    
    vc = char(v);
    val = obj.model.get_fit_param(vc);
    
    set(handles.(vc),'String',val);
    set(handles.([vc(1:end-4) '_sldr']),'Value',val);
    
    %display([vc ' with value: ' num2str(val)])
end % for

obj.update_form_factor()
obj.update_pd();
obj.update_psd();


end

