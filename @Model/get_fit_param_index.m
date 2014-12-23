function ind = get_fit_param_index(obj,tag)
%GET_FIT_PARAM_IND Returns the linear index of fit parameter with specified
%tag
%   
% ind = get_fit_param_index(obj,tag)
%
% Parameters
%
% tag       String tag of the ui element corresponding to the fit parameter
%
% Returns
%
% ind       Linear index of the fit parameter as double
%

ind = obj.param_map(tag);

end

