function m = mean(obj,~)
%MEAN Mean of the histogram distribution
%   m = mean()
%
%   Returns
%   m           mean of the distribution
%
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

w = mean(diff(obj.rpsd));
m = sum(obj.rpsd .* obj.hpsd  .* w);

end

