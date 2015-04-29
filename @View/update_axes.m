function update_axes(obj)
%UPDATE_AXES Updates all the axis of the active Axes_layout in Figure

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

obj.active_layout.update_sources();

drawnow();

end

