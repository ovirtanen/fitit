function prev_state = switch_enable_panels(obj,input)
%ENABLE_PANELS Toggles 'Enable' property in UIControls in given parameter panels.
%   
%   prev_state = switch_enable_panels(toggle)
%   prev_state = switch_enable_panels(state)
%
%   switch_enable_panels(toggle)
%
%   Parameters
%   toggle          'on' or 'off' whether panels are to be enabled or
%                   disabled
%   state          Cell array of strings in the same format as prev_state
%   
%   Returns
%   prev_state      Cell array of strings with entries 'on' or 'off' for
%                   each control depending on their Visibility property
%                   before the toggle
%
% Shitty function but I'm out of juice for today.

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.


controls = {obj.bg_panel obj.br_panel obj.p_panel obj.d_panel};
controls = controls(~cellfun(@isempty,controls));


f = @(x) [x.Children];

% controls is a cellarray, each cell containing the handles to the
% UIControls in the panels
controls = cellfun(f,controls,'UniformOutput',false);
controls = cat(1,controls{:});
prev_state = arrayfun(@(x) x.Enable, controls, 'UniformOutput',false);

if iscellstr(input)
   
    for i = 1:numel(controls)
       
        controls(i).Enable = input{i};
        
    end
    
    return;
    
end

switch input
      
    % treat bg_panel as special case
    case 'on'
        
        set(controls,'Enable','on');
        
    case 'off'
        
        set(controls,'Enable','off');
            
    otherwise
            
        error('Invalid toggle state.');
    
end % switch



end
