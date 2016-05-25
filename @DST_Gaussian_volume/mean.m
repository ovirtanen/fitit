function m = mean(obj)
%MEAN Mean of the Gaussian with current parameters
%   m = mean()
%
%   Returns
%   m           mean of the distribution
%
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

p = cell2mat(obj.params(:,2));
[rpsd,p,w] = obj.psd(50,p);
m = w.* sum(rpsd.*p);

end

