function [min,val,max] = get_min_val_max(obj,lin_ind)
%GET_MIN_MAX_VAL Returns the corresponding minimum, value and maximum of
%based on linear indice of any of these in Model.fit_param.
%   
% [min,val,max] = get_min_val_max(obj,lin_ind)
%
% Parameters
% 
% lin_ind       Linear index of either min, val or max ui element
%
% Returns
%
% min           The minimum limit of this set
% val           The value of this set
% max           The maximum limit of this set


[r,~] = ind2sub(size(obj.fit_param),lin_ind); % get the right row in model.fit_params

min = obj.fit_param{r,1};
val = obj.fit_param{r,2};
max = obj.fit_param{r,3};


end

