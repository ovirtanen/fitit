classdef Controller < handle
    %CONTROLLER Controller class for FitIt
    %   
    %   obj = Controller(m)
    %
    %   Parametres
    %   m           A Model instance
    %
    
    properties (SetAccess = private)
        
        model;
        view;
        fr;
        fw;
        
    end
    
    methods (Access = public)
        
        function obj = Controller(m)
            
            obj.model = m;
            
            obj.view = View(obj,m);
            
            obj.fr = File_reader('.txt');
            obj.fw = [];
            
        end % constructor
        
        % OTHER PUBLIC
        
        import_data(obj,ms);
        add_data_set_to_model(obj,ds);
        swap_distribution(obj,dist);
        swap_s_model(obj,sm);
        
        % CALLBACKS
        
        bg_enable_callback(obj,hObject,callbackdata);
        check_box_callback(obj,hObject,callbackdata);
        dist_menu_callback(obj,hObject,callbackdata);
        edit_box_callback(obj,hObject,callbackdata);
        load_data_set_callback(obj,hObject,callbackdata);
        model_menu_callback(obj,hObject,callbackdata);
        slider_callback(obj,hObject,callbackdata);
               
    end % public methods
    
end

