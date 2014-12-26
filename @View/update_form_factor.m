function update_form_factor(obj)
%UPDATE_FORM_FACTOR Fetches the form factor data from Model and updates the
%form_factor_axes

handles = guidata(obj.gui);

ffa = handles.form_factor_axes;

% If empirical data will be loaded, it will push the calculated data from
% ffa.Children(1) to ffa.Children(2). Calculated data will always be at the
% end of the array at position ffa.Children(end).

ffa.Children(end).XData = obj.model.qfit;
ffa.Children(end).YData = obj.model.fit;

end

