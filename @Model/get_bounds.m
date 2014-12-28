function [lb,ub] = get_bounds(obj)
%GET_BOUNDS Returns the upper and lower fit bounds
%
% [lb,ub] = get_bounds()
%
% Returns
% lb        lower bounds as an array
% ub        upper bounds as an array
%

lb = cell2mat(obj.fit_param(:,1));
ub = cell2mat(obj.fit_param(:,3));

f = obj.get_fixed_status();
p = cell2mat(obj.fit_param(:,2));

% For the fixed fit parameters set the bounds to the value of the fit
% parameter
lb(f) = p(f);
ub(f) = p(f);

end

