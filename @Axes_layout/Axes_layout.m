classdef Axes_layout < handle
    %AXES_LAYOUT A class for keeping track of different axes layouts and
    %their Graphics_sources
    % 
    
    properties (SetAccess = private)
        
        % minimum dimensions of the output panel
        
        axes_panel;
        
        min_width;
        min_height;
        top_spacer;
        bottom_spacer;
        
    end %
    
    properties (Access = private)
        
        view;
        g_sources;
        
    end
    
    methods (Access = public)
        
        function obj = Axes_layout(view,gui,type)
            
            obj.view = view;
            obj.g_sources = [];
            
            o_units = gui.Units;
            gui.Units = 'pixels';
            
            g_size = gui.Position;
            g_size = g_size(3:end);
            
            obj.axes_panel = uipanel('Parent',gui,'Visible','off');
            obj.axes_panel.Tag = 'output_panel';
            obj.axes_panel.Title = 'Output';
            obj.axes_panel.BorderType = 'EtchedIn';
            obj.axes_panel.Units = 'pixels';
            
            % Panel width and position
            % -------------------------------------------------------------
            
            obj.min_width = 800;        % px
            obj.min_height = 480;       % px
            
            obj.top_spacer = 50;        % px
            obj.bottom_spacer = 20;     % px

            pos_l = 520 + 20; % Controls width = 520 px + 20 px spacer

            p_width = max([obj.min_width g_size(1)- 540 - 20]);
            p_height = max([obj.min_height g_size(2) - (obj.top_spacer + obj.bottom_spacer)]); 
            
            pos_b = g_size(2) - obj.top_spacer - p_height;
            
            obj.axes_panel.Position = [pos_l, pos_b, p_width, p_height];
            
            % -------------------------------------------------------------
            switch type
                
                case 'default'
                    
                    si = obj.initialize_si_axes();
                    cp = obj.initialize_cp_axes(si);
                    d = obj.initialize_dist_axes(si);
                    
                otherwise 
                    
                    error('Layout type not recognized.');
                
                
            end % switch
            
            obj.axes_panel.Visible = 'on';
            gui.Units = o_units;
            
        end % constructor
       
        add_g_source(obj,gs);
        si = obj.initialize_si_axes(obj);
        cp = initialize_cp_axes(obj,si);
        d = initialize_dist_axes(obj,si);
        update_sources(obj);
        
    end % public methods
    
    
    
end

