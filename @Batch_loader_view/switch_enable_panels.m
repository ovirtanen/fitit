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

% Copyright (c) 2015,2016 Otto Virtanen
% All rights reserved.




controls = findobj(obj.gui);
filter = arrayfun(@(x) isa(x,'matlab.ui.control.UIControl'),controls);
controls = controls(filter);

if iscellstr(input)
   
    for i = 1:numel(controls)
       
        controls(i).Enable = input{i};
        
    end
    
    return;
    
end

prev_state = arrayfun(@(x) x.Enable, controls,'UniformOutput',false); % Enable is either 'on' or 'off'

switch input
      
    case 'on'
        
        set(controls,'Enable','on');
        
    case 'off'
        
        set(controls,'Enable','off');
            
    otherwise
            
        error('Invalid toggle state.');
    
end % switch


end
