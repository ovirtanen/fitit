function n = n_total_params(obj)
%N_TOTAL_PARAMS Returns the total number of parameters accepted by the
%model, including the number of parameters accepted by all the child models
%such as distribution instances
%   
%
%   n = n_total_params()
%
% Returns
% n         The total number of parameters accepted the model and all child
%           models
%
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.


n = numel(obj.params(:,3));


end

