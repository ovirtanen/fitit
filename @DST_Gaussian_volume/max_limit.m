function mx = max_limit(obj)
%MAX_LIMIT Maximum limit of the distribution
%  

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

mx = nthroot(3.*obj.get_param('mean_max')./(4.*pi),3);

end

