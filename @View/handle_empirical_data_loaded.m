function handle_empirical_data_loaded(obj,src,evnt)
%HANDLE_EMPIRICAL_DATA_LOADED Handler for empirical_data_loaded
%   Detailed explanation goes here
%
% Parameters
% obj           Calling View instance
% src           A meta.property object describing the object that is the
%               source of the property event (Model in this case)
% evnt          Event data object


m = src;
handles = guidata(obj.gui);

ffa = handles.form_factor_axes;

if numel(ffa.Children) == 1

    hold(ffa,'on');

    errorbar(ffa,m.q,m.intensity,m.std,'o');
    
    hold(ffa,'off');
    
    ffa.YLabel.String = 'Intensity (cm^{-2})';
    ffa.XLabel.String = 'q (nm^{-1})';
    ffa.YScale = 'log';
    ffa.YLim = [5e-6 0.2e1];
    
    
elseif numel(ffa.Children) == 2
    
    ffa.Children(1).XData = obj.model.q;
    ffa.Children(1).YData = obj.model.intensity;
    ffa.Children(1).LData = obj.model.std;
    ffa.Children(1).UData = obj.model.std;
    
else
    
    err = MException('FitIt:UIError',...
        'Error in updating form_factor_axes.');
    throw(err);
    
end % if


end

