function p = get_param(obj,tag)
%GET_PARAM Returns a specific Distribution parameter
%
%   p = get_param(tag)
%
%   Parameters
%   tag             Ui element tag string
%
%   Returns
%   p               Value of the parameter

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

index = obj.param_map(tag);
p = obj.params{index};

end

