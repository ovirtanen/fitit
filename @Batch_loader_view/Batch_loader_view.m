classdef Batch_loader_view
    %BATCH_LOADER_VIEW View class for the Batch_loader GUI
    % 
    
    % Copyright (c) 2015, Otto Virtanen
    % All rights reserved.
    
    
    properties (SetAccess = private)
        
        gui;
        view;
        
        pupdate_panel;     % Parameter update panel
        bfit_panel;        % Batch fit panel
        manage_panel;      % Manage data panel
        save_panel;        % Save panel
        
    end
    
    properties (Access = private)
       
        spacers;
        
    end
    
    methods (Access = public)
        
        function obj = Batch_loader_view(view)
            
            obj.view = view;
            
            obj.spacers = struct('btn_spacer',10,...        % Pushbutton spacer; px
                                 'b_group_spacer',15,...    % Button group spacer; px
                                 'checkbox_spacer',5,...     % Checkbox spacer; px
                                 'panel_spacer',10,...      % Panel horizontal spacer; px
                                 'rbtn_spacer',15,...       % Radio button spacer; px   
                                 'btn_height',30,...        % Push button height; px
                                 'checkbox_height',20,...    % Checkbox height; px
                                 'rbtn_height',20);         % Radio button height; px
            
            
        end
        
        fig = initialize_gui(obj);
        p = initialize_bfit_panel(obj,panel_width);
        p = initialize_manage_panel(obj,panel_width);
        p = initialize_pupdate_panel(obj,panel_width);
        p = initialize_save_panel(obj,panel_width);
        
    end
    
end

