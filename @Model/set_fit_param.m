function set_fit_param(obj,tag,value)
%SET_FIT_PARAM Set function to change the fit parameters
% Parameters
%
% tag           Name of the gui element which will be changed
% value         New value for the gui element
%

index = obj.param_map(tag);

obj.fit_param{index} = value;

% Broadcast which parameter has been changed, so that View knows to update
% itself

notify(obj,'fit_params_changed',Fit_params_event_data(tag));

end

