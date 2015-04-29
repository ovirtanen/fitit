function change_position(element,l,h)
%CHANGE_POSITION Changes the position of an UI element
%
%   change_position(element,l,h)
%
%   Parameters
%   element         Reference to the UI element
%   l               New left position
%   h               New height
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

current_pos = element.Position;

new_pos = [l h current_pos(3:end)];

element.Position = new_pos;

end
