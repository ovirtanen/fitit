function set_param(obj,tag,value)
%GET_PARAM Sets a specific Distribution parameter according to tag
%
%   p = set_param(tag,value)
%
%   Parameters
%   tag             Ui element tag string
%   value           New value
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

index = obj.param_map(tag);
obj.params{index} = value;

end

