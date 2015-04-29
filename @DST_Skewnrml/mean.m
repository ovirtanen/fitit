function m = mean(obj,~)
%MEAN Mean of the Skew normal with current parameters
%   m = mean()
%
%   Returns
%   m           mean of the distribution
%
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

loc = obj.get_param('loc_val');
wdth = obj.get_param('b_val');
skwns = obj.get_param('c_val');

m = loc + skwns ./ sqrt(1+skwns.^2).*sqrt(2./pi).*wdth;

end

