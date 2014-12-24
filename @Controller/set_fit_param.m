function set_fit_param(obj,tag,value)
%SET_FIT_PARAM Tells Model to change fit_param
%      
% set_fit_param(tag,value)
%
% Parameters
%
% tag       Tag string of the ui element corresponding to the parameter
% value     New value for the parameter
%

obj.model.set_fit_param(tag,value);

end

