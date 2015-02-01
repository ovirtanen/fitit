classdef (ConstructOnLoad = true) Fit_params_event_data < event.EventData
    %FIT_PARAMS_EVENT_DATA Event data object for fit_params_changed event
    %in Model
    %   Detailed explanation goes here
    
    properties
        
        tag;
        
    end
    
    methods (Access = public)
        
        function obj = Fit_params_event_data(t)
            
            if not(ischar(t))
                error('Tag must be a string!');
            end;
            
            obj.tag = t;
            
        end % constructor
        
    end
    
end

