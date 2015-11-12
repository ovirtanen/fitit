function p_std = estimate_p_std(obj)
%ESTIMATE_P_STD Estimates the standard deviation in the parameter vector p
%   
%   p_std = estimate_p_std()
%
% Returns
% p_std         Estimated standard deviation for the total parameter vector
%               p. STD of fixed parameters will be -1;

j = obj.total_jacobian();
np = size(j,2);

% Free parameters
free_filter = obj.get_total_free_params();
pf = 1:np;
pf = pf(free_filter);

p_std = -1.*ones(np,1);

j = j(:,pf);

e = vertcat(obj.data_sets.std_exp);

p_std(pf) = sqrt(diag(pinv(j)*diag(e.^2)*pinv(j)'));

end

