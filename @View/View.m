classdef View < handle
    %VIEW View class for FitIt
    %   
    %   obj = View(c,m) creates a new Figure and initializes GUI according
    %   to the state of the Model
    %
    %   Parameters
    %   c       Controller instance
    %   m       Model instance
    %
    
    
    properties (SetAccess = private)
        
        version;
        
        gui;
        controller;
        model;
        
        bg_panel;   % background panel
        p_panel;    % scattering model parameter panel
        d_panel;    % distribution panel
        f_button;   % fit button
        
    end % read-only
    
    properties (Access = private)
        
        active_layout;
        layouts;
             
    end % internal
    
    methods (Static)
       
        change_position(e,l,h);
        th = total_height_elements(v_spacer,varargin);
        
    end
    
    methods (Access = public)
        
        function obj = View(c,m)
            
            obj.version = 1.0;
            
            obj.controller = c;
            obj.model = m;
            obj.layouts = [];
            
            obj.gui = obj.initialize_gui();
            
        end % constructor
        
        %%% other public
        
        initialize_g_sources_for_data_set(obj,ds);
        display_about_box(obj);
        display_comfort_me_box(obj);
        delete_g_sources_in_si_axes(obj);
        function disable_f_button(obj)
           
            obj.f_button.Enable = 'off';
            obj.f_button.String = 'Fitting...';
            
        end
        function disable_panels(obj)
           
            obj.bg_panel.Enable = 'off';
            obj.p_panel.Enable = 'off';
            obj.d_panel.Enable = 'off';
            
        end
        function enable_panels(obj)
           
            obj.bg_panel.Enable = 'on';
            obj.p_panel.Enable = 'on';
            obj.d_panel.Enable = 'on';
            
        end
        
        %%% swappers
        
        swap_panel(obj,tag);
        
        %%% Updaters
        
        update_axes(obj);
        update_f_button_status(obj);
        update_vals_from_model(obj);
                    
    end % public methods
    
    methods (Access = private)
        
        %%% GUI initialization methods
        
        align_control_panels(obj,p,h_spacer,top_spacer,v_spacer,varargin);
        g = initialize_gui(obj);
        bg = initialize_bg_panel(obj,p);
        f = initialize_figure(obj);
        b = initialize_fit_button(obj,p)
        initialize_menu(obj,p);
        p = initialize_param_panel(obj,p,source,tag);
        [bg,pp,dp,b]=initialize_smodel_controls(obj,f)
        resize_figure(obj,bottom_spacer,new_height);
        
    end % private methods
    
end

