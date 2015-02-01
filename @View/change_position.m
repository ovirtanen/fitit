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


current_pos = element.Position;

new_pos = [l h current_pos(3:end)];

element.Position = new_pos;

end
