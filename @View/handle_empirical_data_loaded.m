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
    
    % Flip children so that the calculated fit is on the top of the
    % empirical data
    ffa.Children = [ffa.Children(end) ffa.Children(1)];
    
    ffa.YLabel.String = 'Intensity (cm^{-2})';
    ffa.XLabel.String = 'q (nm^{-1})';
    ffa.YScale = 'log';
    
    ffa.XLim = [0 1.1.*max(m.q)];
    %ffa.YLim = [5e-6 0.2e1];
    
    if all(obj.model.get_fixed_status())
        
        set(handles.calculate_btn,'String','All values fixed');
        
    else
        
        set(handles.calculate_btn,'String','Fit');
        set(handles.calculate_btn,'Enable','on');
        
    end % if
    
elseif numel(ffa.Children) == 2
    
    ffa.Children(end).XData = m.q;
    ffa.Children(end).YData = m.intensity;
    ffa.Children(end).LData = m.std;
    ffa.Children(end).UData = m.std;
    
else
    
    err = MException('FitIt:UIError',...
        'Error in updating form_factor_axes.');
    throw(err);
    
end % if


end

