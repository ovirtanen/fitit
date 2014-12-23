classdef View < handle
    %VIEW View class for FitIt program.
    %   Written after example of Chris Schwarz.
    
    properties (SetAccess = private)
        
        gui;
        model;
        controller;
        
    end
    
    methods (Access = public)
        
        function obj = View(m,c)
            
            obj.model = m;
            obj.controller = c;
            
            % GUIDE graphics object. Here the properties 'controller',
            % obj.controller are passed as varargin to
            % fit_it_ui_OpeningFcn. See fit_it_ui help for details.
            
            obj.gui = fit_it_ui('controller',obj.controller,'view',obj);
            
            % Listeners for changes in Model
            
        end % constructor
        
        b = ui_limits_check(obj,inp,type,tag);
        edit_box_callback(obj,hObject,inp,tag,type);
        
    end % public methods
    
    methods (Access = private)
        
        handle_property_events(obj,src,evnt);
        
    end
    
end

