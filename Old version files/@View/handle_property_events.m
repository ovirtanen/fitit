function handle_property_events(obj,src,evnt)
%HANDLE_PROPERTY_EVENTS Callback function for property events
%  Detailed explanation goes here
%
%
% Parameters
%
% obj           Calling View instance
% src           A meta.property object describing the object that is the
%               source of the property event (Model in this case)
% evnt data     A event.PropertyEvent object containing information about the event
%

evntobj = evnt.AffectedObject;
handles = guidata(obj.gui); % get GUIDE's handles structure http://de.mathworks.com/help/matlab/ref/guidata.html


switch src.Name % name of the property in Model that triggered the event
    
    case 'intensity'
        
    case 'std'
        
    case 'q'
        
    case 'qfit'   
        
    case 'fit'
        
    case 'rpd'
        
    case 'pd'
        
    case 'rpsd'
        
    case 'psd'
    
    
end % switch


end

