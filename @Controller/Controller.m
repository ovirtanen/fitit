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
        
        % Factors to convert imported q values to inverse nanometers
        import_q_conversion_factor;
        % lines to skip in loaded data files, depending the instrument
        % used. Analogous to import_q_conversion_factor
        import_line_skip;
        
        gpu;
        
    end
    
    properties (Access = private)
       
        gpu_enabled_global;
        par_enabled_global;
       
        import_filter_spec;
      
    end
    
    %%
    methods (Access = public)
        
        %% Constructor
        function obj = Controller(m,mode)
            
            obj.gpu_enabled_global = 0;
            obj.par_enabled_global = 0;
            
            obj.import_filter_spec = {'*.txt' 'Text import (.txt) (nm^{-1})';...
                                       '*.DAT' 'KWS-2 file (a^{-1})'};
            
            % Factors to convert imported q values to inverse nanometers
            obj.import_q_conversion_factor = [1;...     % Text import (.txt) (nm^{-1})
                                              10        % KWS-2 file (a^{-1})
                                              ];
            obj.import_line_skip = [0;                  % Text import (.txt) (nm^{-1})
                                    2;                  % KWS-2 file (a^{-1})
                                    ];  
                                        
            
            obj.model = m;
            obj.fr = File_reader(obj.import_filter_spec);
            obj.fw = FileWriter(obj,'.txt');
            
                       
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
            
            if numel(obj.import_q_conversion_factor) ~= numel(obj.import_line_skip)
                
                error('Remember to update both import_q_conversion_factor and import_line_skip.');
                
            end
            
        end % constructor
        
        %% OTHER PUBLIC
        
        [d,p] = import_data(obj,input);
        d = import_histogram_data(obj);
        load_from_data_node(obj,dn);
        multi_lsq_fit(obj,node_indices,fitmode,prg);
        d = raw_data_to_array(obj,c);
        p_table_export(obj,nodes);
        swap_distribution(obj,dist);
        swap_s_model(obj,sm);
        sm_ui_cleanup(obj,sm_name);
        text_file_export(obj,nodes);
        
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
        open_bl_callback(obj,hObject,callbackdata);
        par_switch_callback(obj,hObject,callbackdata);
        save_data_callback(obj,hObject,callbackdata);
        si_scale_callback(obj,hObject,callbackdata);
        slider_callback(obj,hObject,callbackdata);
        quit_callback(obj,hObject,callbackdata);
        
        %% Batch Loader CALLBACKS
        
        bl_batch_load_callback(obj,hObject,callbackdata); 
        bl_close_req_callback(obj,hObject,callbackdata);
        bl_import_data_callback(obj,hObject,callbackdata);
        bl_ungroup_to_datasets(obj,hObject,callbackdata);
        bl_set_path_callback(obj,hObject,callbackdata);
        bl_save_now_callback(obj,hObject,callbackdata);
        bl_table_cell_selection_callback(obj);
        bl_table_callback(obj,hObject,callbackdata,bl_view);
               
    end % public methods
    
end

