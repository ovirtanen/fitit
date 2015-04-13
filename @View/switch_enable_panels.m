function switch_enable_panels(obj,toggle)
%ENABLE_PANELS Toggles 'Enable' property in UIControls in given parameter panels.
%   
%   switch_enable_panels(toggle)
%
%   Parameters
%   toggle          'on' or 'off' whether panels are to be enabled or
%                   disabled
%

controls = {obj.bg_panel obj.p_panel obj.d_panel};

f = @(x) [x.Children];

% controls is a cellarray, each cell containing the handles to the
% UIControls in the panels
controls = cellfun(f,controls,'UniformOutput',0);
   
switch toggle
      
    % treat bg_panel as special case
    case 'on'
        
        if obj.model.bg.enabled
            
            set(controls{1},'Enable','on');
            
        else 
           
            chck = findobj(obj.bg_panel,'Tag','bgonoff_chck');
            chck.Enable = 'on';
            
        end % if
        
        for i = 2:numel(controls)
        
            set(controls{i},'Enable','on');
            
        end
        
    case 'off'
        
        for i = 1:numel(controls)
            
            set(controls{i},'Enable','off');
            
        end
            
    otherwise
            
        error('Invalid toggle state.');
    
end % switch



end
