function update_form_factor(obj)
%UPDATE_FORM_FACTOR Fetches the form factor data from Model and updates the
%form_factor_axes

handles = guidata(obj.gui);

ffa = handles.form_factor_axes;

% If empirical data will be loaded, it will push the calculated data from
% ffa.Children(1) to ffa.Children(2). Calculated data will always be at the
% end of the array at position ffa.Children(end).

ffa.Children(1).XData = obj.model.qfit;
ffa.Children(1).YData = obj.model.fit;

ffa.XLim = [0 1.1*max(obj.model.qfit)];
ffa.YLim = [0.1.*min(obj.model.fit) 10*max(obj.model.fit)];

end

