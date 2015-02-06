function update_axes(obj)
%UPDATE_AXES Updates all the axis of the active Axes_layout in Figure

obj.active_layout.update_sources();

drawnow();

end

