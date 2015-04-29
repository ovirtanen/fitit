function delete_g_sources_in_si_axes(obj)
%DELETE_G_SOURCES_IN_SI_AXES Deletes all the Graphics_source instances for
%si axes in the active layout
%
%   delete_g_sources_in_si_axes()

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

obj.active_layout.delete_si_sources();

end

