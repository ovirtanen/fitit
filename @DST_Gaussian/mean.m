function m = mean(obj,~)
%MEAN Mean of the Gaussian with current parameters
%   m = mean()
%
%   Returns
%   m           mean of the distribution
%
%

m = obj.get_param('mean_val');

end

