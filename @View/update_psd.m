function update_psd(obj)
%UPDATE_PSD Fetches the psd from Model and updates the
%psd_axes
%   Detailed explanation goes here

handles = guidata(obj.gui);
m = obj.model;

psda = handles.psd_axes;

psda.Children(1).XData = obj.model.rpsd;
psda.Children(1).YData = obj.model.psd;
psda.YLim = [0 1.1 .* max(obj.model.psd)];
psda.XLim = [cell2mat(m.fit_param(m.param_map('meanr_min'))) cell2mat(m.fit_param(m.param_map('meanr_max')))];


end

