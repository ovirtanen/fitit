classdef Controller
    %CONTROLLER Controller for FitIt
    %   Detailed explanation goes here
    %
    % c = Controller(m)
    % 
    % Parameters
    % m         Model instance
    %
    % Returns
    % c         Controller instance
    %

    
    properties (SetAccess = private)
        
        model;
        view;
        fr;
        
    end
    
    methods (Access = public)
        
        function obj = Controller(m)
            
            obj.model = m;
            obj.fr = File_reader('.txt');
            obj.view = View(m,obj);
           
        end % constructor
        
        set_fit_param(obj,tag,value);
        import_data(obj);
 
    end % public methods
    
end

