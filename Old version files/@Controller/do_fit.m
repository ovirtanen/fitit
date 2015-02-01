function do_fit(obj)
%DO_FIT Performs least squares fit on empirical data and updates model &
%view
%
% do_fit()
%

guidata(obj.view.gui);
handles = guidata(obj.view.gui);

% disable fit button while doing the fit
set(handles.calculate_btn,'String','Fitting...');
obj.view.disable_inputs();
drawnow;

[p,exitflag] = obj.model.lsqfit();

obj.model.set_all_fit_param(p,'fitting');

set(handles.calculate_btn,'String','Fit');
obj.view.enable_inputs();

end

