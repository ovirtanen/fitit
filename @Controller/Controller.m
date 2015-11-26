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
    
    
    %% Properties
    
    properties (SetAccess = private)
       
        model;
        view;
        fr;
        fw;
        
        gpu;
        
    end
    
    properties (Access = private)
       
        gpu_enabled_global;
        par_enabled_global;
       
        
    end
    
    %%
    methods (Access = public)
        
        %% Constructor
        function obj = Controller(m,mode)
            
            obj.model = m;
            obj.fr = File_reader('.txt');
            obj.fw = FileWriter(obj,'.txt');
            
            obj.gpu_enabled_global = 0;
            obj.par_enabled_global = 0;
            
            % Select the default GPU if available
            if gpuDeviceCount > 0
                
                try
                
                    obj.gpu = gpuDevice(1);
                    
                catch ME
                   
                    display('Error with GPU initialization:');
                    display(ME.message);
                    display('Overriding GPU functionality.');
                    
                    obj.gpu = [];
                    
                end
                
            else
                obj.gpu = [];
            end
            
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
        d = raw_data_to_array(obj,c);
        swap_distribution(obj,dist);
        swap_s_model(obj,sm);
        sm_ui_cleanup(obj,sm_name);
        
        %% CALLBACKS
        
        about_menu_callback(obj,hObject,callbackdata);
        bg_enable_callback(obj,hObject,callbackdata);
        br_edit_box_callback(obj,hObject,callbackdata);
        br_enable_callback(obj,hObject,callbackdata);
        br_switch_callback(obj,hObject,callbackdata)
        check_box_callback(obj,hObject,callbackdata);
        comfort_me_callback(obj,hObject,callbackdata);
        dist_menu_callback(obj,hObject,callbackdata);
        edit_box_callback(obj,hObject,callbackdata);
        f_button_callback(obj,hObject,callbackdata);
        gpu_switch_callback(obj,hObject,callbackdata);
        l_curve_callback(obj,hObject,callbackdata);
        load_data_set_callback(obj,hObject,callbackdata);
        load_histogram_callback(obj,hObject,callbackdata);
        minimize_panel_callback(obj,hObject,callbackdata);
        model_menu_callback(obj,hObject,callbackdata);
        par_switch_callback(obj,hObject,callbackdata);
        save_data_callback(obj,hObject,callbackdata);
        si_scale_callback(obj,hObject,callbackdata);
        slider_callback(obj,hObject,callbackdata);
        quit_callback(obj,hObject,callbackdata);
               
    end % public methods
    
end

