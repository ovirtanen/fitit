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
        
        gui;
        controller;
        model;
        
        
    end % read-only
    
    properties (Access = private)
        
        active_layout;
        layouts;
        
        bg_panel;   % background panel
        p_panel;    % scattering model parameter panel
        d_panel;    % distribution panel
        f_button;   % fit button
        
    end % internal
    
    methods (Static)
       
        change_position(e,l,h);
        
    end
    
    methods (Access = public)
        
        function obj = View(c,m)
            
            obj.controller = c;
            obj.model = m;
            obj.layouts = [];
            
            obj.gui = obj.initialize_gui();
            
        end % constructor
        
        %%% other public
        
        add_g_source_for_data_set(obj,ds);
        
        %%% swappers
        
        swap_p_panel(obj);
        swap_d_panel(obj);
        
        %%% Updaters
        
        update_axes(obj);
                    
    end % public methods
    
    methods (Access = private)
        
        %%% GUI initialization methods
        
        align_control_panels(obj,h_spacer,top_spacer,v_spacer,varargin);
        g = initialize_gui(obj);
        bg = initialize_bg_panel(obj,p);
        f = initialize_figure(obj);
        b = initialize_fit_button(obj,p)
        initialize_menu(obj,p);
        p = initialize_param_panel(obj,p,source,tag);
        [bg,pp,dp,b]=initialize_smodel_controls(obj,f)
        resize_figure(obj,nh);
        
    end % private methods
    
end

