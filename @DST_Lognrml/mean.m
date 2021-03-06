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

a = obj.get_param('a_val');
b = obj.get_param('b_val');

m = exp(a+b.^2./2);

end

