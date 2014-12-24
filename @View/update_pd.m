function update_pd(obj)
%UPDATE_PD Fetches the pd from Model and updates the
%pd_axes
%   Detailed explanation goes here


handles = guidata(obj.gui);
m = obj.model;

pda = handles.pd_axes;

pda.Children(1).XData = obj.model.rpd;
pda.Children(1).YData = obj.model.pd;
pda.YLim = [0 1.1 .* max(obj.model.pd)];
pda.XLim = [0 cell2mat(m.fit_param(m.param_map('meanr_max')))];

end

