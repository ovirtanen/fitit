function set_fit_param(obj,tag,value)
%SET_FIT_PARAM Set function to change the fit parameters
% Parameters
%
% tag           Tag string of the gui element that wants to change fit
%               parameter
% value         New value for the gui element
%

% check if the request came from a slider and translate it to appropriate
% _val tag to get the right index.

if strfind(tag,'_sldr')
    
    newtag = [tag(1:end-5) '_val']; % _sldr to _val
    index = obj.param_map(newtag);
    
else
    
    index = obj.param_map(tag);

end

% Broadcast which parameter has been changed, so that View knows to update
% itself

if strfind(tag,'_val')
    
     obj.fit_param{index} = value;
     p = obj.get_all_fit_param('fitting');
     obj.set_fit(p);
     obj.set_pd(p);
     notify(obj,'fit_params_changed_by_box',Fit_params_event_data(tag));
     
elseif any([strfind(tag,'_max') strfind(tag, '_min')])
    
    obj.fit_param{index} = value;
    notify(obj,'fit_params_changed_by_box',Fit_params_event_data(tag));
    
elseif strfind(tag,'_sldr')
    
    obj.fit_param{index} = value;
    p = obj.get_all_fit_param('fitting');
    obj.set_fit(p);
    obj.set_pd(p);
    notify(obj,'fit_params_changed_by_sldr',Fit_params_event_data(tag));
    
end % if

end

