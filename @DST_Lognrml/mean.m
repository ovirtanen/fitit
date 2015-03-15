function m = mean(obj,~)
%MEAN Mean of the Gaussian with current parameters
%   m = mean()
%
%   Returns
%   m           mean of the distribution
%
%

u = obj.get_param('mean_val');
s = obj.get_param('b_val');

m = exp(log(u)+log(s).^2./2);

end

