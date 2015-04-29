function p = get_param_vector(obj)
%GET_PARAM_VECTOR Returns the parameter vector of the distribution instance
%   
%   p = get_param_vector()
%
%   Returns
%   p           Parameter vector with p = params(:,2)
%                     
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

p = cell2mat(obj.params(:,2));


end

