classdef Controller < handle
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
        fr;
        view;
        
    end
    
    methods (Access = public)
        
        function obj = Controller(m)
            
            obj.model = m;
            obj.fr = File_reader('.txt');
            obj.view = View(m,obj);
           
        end % constructor
        
        do_fit(obj);
        import_data(obj);
        save_data(obj);
        set_fit_param(obj,tag,value);
        
 
    end % public methods
    
end

