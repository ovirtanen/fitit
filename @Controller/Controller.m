classdef Controller < handle
    %CONTROLLER Controller class for FitIt
    %   
    %   obj = Controller(m,mode)
    %
    %   Parametres
    %   m           A Model instance
    %   mode        Either 'local' or 'cluster'. In local mode gui is
    %               initialized, in cluster mode not.
    %
    
    % Copyright (c) 2015, Otto Virtanen
    % All rights reserved.
    
    
    properties (SetAccess = private)
       
        model;
        view;
        fr;
        fw;
        
    end
    
    
    methods (Access = public)
        
        %% Constructor
        function obj = Controller(m,mode)
            
            obj.model = m;
            obj.fr = File_reader('.txt');
            obj.fw = FileWriter(obj,'.txt');
            
            switch mode
               
                case 'local'
                    
                    obj.view = View(obj,m);
                    
                case 'cluster'
                    
                    obj.view = [];
                    
                otherwise
                    
                    error('Invalid mode.')
                
            end
            
        end % constructor
        
        %% OTHER PUBLIC
        
        d = import_data(obj,ms);
        d = import_histogram_data(obj);
        add_data_set_to_model(obj,d);
        d = raw_data_to_array(obj,c);
        swap_distribution(obj,dist);
        swap_s_model(obj,sm);
        
        %% CALLBACKS
        
        about_menu_callback(obj,hObject,callbackdata);
        bg_enable_callback(obj,hObject,callbackdata);
        check_box_callback(obj,hObject,callbackdata);
        comfort_me_callback(obj,hObject,callbackdata);
        dist_menu_callback(obj,hObject,callbackdata);
        edit_box_callback(obj,hObject,callbackdata);
        f_button_callback(obj,hObject,callbackdata);
        load_data_set_callback(obj,hObject,callbackdata);
        load_histogram_callback(obj,hObject,callbackdata);
        model_menu_callback(obj,hObject,callbackdata);
        save_data_callback(obj,hObject,callbackdata);
        si_scale_callback(obj,hObject,callbackdata);
        slider_callback(obj,hObject,callbackdata);
        quit_callback(obj,hObject,callbackdata);
               
    end % public methods
    
end

