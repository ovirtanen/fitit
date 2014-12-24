function update_form_factor(obj)
%UPDATE_FORM_FACTOR Fetches the form factor data from Model and updates the
%form_factor_axes

handles = guidata(obj.gui);

ffa = handles.form_factor_axes;

ffa.Children(1).XData = obj.model.qfit;
ffa.Children(1).YData = obj.model.fit;


end

