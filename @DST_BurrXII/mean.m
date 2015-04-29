function m = mean(obj,~)
%MEAN Mean of the Burr XII with current parameters
%   m = mean()
%
%   Returns
%   m           mean of the distribution
%
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

% ack(1): a, ack(2): c, ack(3):k
ack = cell2mat(obj.params(:,2));

m = DST_BurrXII.burr_moments(1,ack(1),ack(2),ack(3));

end

