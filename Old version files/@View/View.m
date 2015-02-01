classdef View < handle
    %VIEW View class for FitIt program.
    %   Written after example of Chris Schwarz.
    
    properties (SetAccess = private)
        
        gui;
        model;
        controller;
        version;
        
    end
    
    methods (Access = public)
        
        function obj = View(m,c)
            
            obj.version = '0.1';
            
            obj.model = m;
            obj.controller = c;
            
            % GUIDE graphics object. Here the properties 'controller',
            % obj.controller, 'view', obj are passed as varargin to
            % fit_it_ui_OpeningFcn. See fit_it_ui help for details.
            
            obj.gui = fit_it_ui('controller',obj.controller,'view',obj);
            
            % Listeners for changes in Model
            
            addlistener(obj.model,'all_fit_params_changed',...
                        @(src,evnt) handle_all_fit_params_changed(obj,src,evnt)); 
            
            addlistener(obj.model,'fit_params_changed_by_box',...
                        @(src,evnt) handle_fit_param_events_by_box(obj,src,evnt));
                    
            addlistener(obj.model,'fit_params_changed_by_sldr',...
                        @(src,evnt) handle_fit_param_events_by_sldr(obj,src,evnt));
                    
            addlistener(obj.model,'fit_params_changed_by_chckbox',...
                        @(src,evnt) handle_fit_param_events_by_chckbox(obj,src,evnt));        
                    
            addlistener(obj.model,'empirical_data_loaded',...
                        @(src,evnt) handle_empirical_data_loaded(obj,src,evnt));       
            
        end % constructor
        
        % General
        
        b = ui_limits_check(obj,inp,type,tag);
        disable_inputs(obj);
        enable_inputs(obj);
        
        % Callbacks
        
        about_menu_callback(obj);
        chck_box_callback(obj,inp,tag);
        close_btn_callback(obj,hObject);
        edit_box_callback(obj,hObject,inp,tag,type);
        fit_callback(obj);
        import_data_callback(obj);
        save_menu_callback(obj);
        slider_callback(obj,hObject,inp,tag);
        
         
        % Updates
        
        update_form_factor(obj);
        update_psd(obj);
        update_pd(obj);
        
        % Initialization
        
        initialize_form_factor_axes(obj,axes);
        initialize_residual_axes(obj,axes);
        initialize_pd_axes(obj,axes);
        initialize_psd_axes(obj,axes);
        
        
    end % public methods
    
    methods (Access = private)
        
        % handlers
        
        handle_property_events(obj,src,evnt);
        handle_all_fit_params_changed(obj,src,evnt);
        handle_fit_param_events_by_box(obj,src,evnt);
        handle_fit_param_events_by_chckbox(obj,src,evnt);
        handle_fit_param_events_by_sldr(obj,src,evnt);
        handle_empirical_data_loaded(obj,src,evnt);
        
    end
    
end

