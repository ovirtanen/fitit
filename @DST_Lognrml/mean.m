function m = mean(obj,~)
%MEAN Mean of the Gaussian with current parameters
%   m = mean()
%
%   Returns
%   m           mean of the distribution
%
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

u = obj.get_param('mean_val');
s = obj.get_param('b_val');

m = exp(log(u)+log(s).^2./2);

end

