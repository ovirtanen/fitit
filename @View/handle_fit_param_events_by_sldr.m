function handle_fit_param_events_by_sldr(obj,src,evnt)
%HANDLE_FIT_PARAM_EVENTS_BY_SLDR Handler for slider events
%   
% handle_fit_param_events_by_sldr(src,evnt)
%
% Parameters
% obj           Calling View instance
% src           A meta.property object describing the object that is the
%               source of the property event (Model in this case)
% evnt          A Fit_params_fit_data object containing information about the event


m = src;
handles = guidata(obj.gui);

tag = evnt.tag;
tag = [tag(1:end-5) '_val']; % change _sldr to _val

val = m.get_fit_param(tag);

set(handles.(tag),'String',val);
obj.update_form_factor();

% tags that require psd to update
if any([strfind(tag,'meanr') strfind(tag,'pdisp')])
   
    obj.update_psd();

end

% tags that require polarization density profile to update
if any([strfind(tag,'meanr') strfind(tag,'dr') strfind(tag,'epds') strfind(tag,'fuzz')])
    
    obj.update_pd();
    
end

end

