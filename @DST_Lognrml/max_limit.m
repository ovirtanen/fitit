function mx = max_limit(obj)
%MAX_LIMIT Maximum limit of the distribution
%  

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

mx = exp(obj.get_param('a_max'));

end

