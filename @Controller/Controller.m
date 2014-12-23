classdef Controller
    %CONTROLLER Controller for FitIt
    %   Detailed explanation goes here
    
    properties
        
        model;
        view;
        
    end
    
    methods (Access = public)
        
        function obj = Controller(m)
            
            obj.model = m;
            obj.view = View(m,obj);
            
        end % constructor
        
        set_fit_param(obj,tag,value);
        
        
    end
    
end

