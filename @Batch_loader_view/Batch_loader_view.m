classdef Batch_loader_view < handle
    %BATCH_LOADER_VIEW View class for the Batch_loader GUI
    % 
    
    % Copyright (c) 2015, Otto Virtanen
    % All rights reserved.
    
    
    properties (SetAccess = private)
        
        gui;
        view;
        
        file_table;        % Table for displaying loaded data in GUI
        
        pupdate_panel;     % Parameter update panel
        bfit_panel;        % Batch fit panel
        manage_panel;      % Manage data panel
        save_panel;        % Save panel
        
        push_buttons;      % uicontroller array holding all the push buttons in the GUI
        booleans;          % struct holding user selections from radio buttons and check boxes
        
        last_t_indices;    % Last indices selected in the table
        table_timer;       % Timer object for tracking the table selection
        
    end
    
    properties (Access = private)
       
        spacers;
          
    end
    
    methods (Access = public)
        
        function obj = Batch_loader_view(view)
            
            obj.gui = [];
            obj.view = view;
            
            obj.pupdate_panel = [];  
            obj.bfit_panel = [];        
            obj.manage_panel = [];     
            obj.save_panel = [];     
        
            
            obj.push_buttons = [];
            
            obj.spacers = struct('btn_spacer',10,...        % Pushbutton spacer; px
                                 'b_group_spacer',15,...    % Button group spacer; px
                                 'checkbox_spacer',5,...     % Checkbox spacer; px
                                 'panel_spacer',10,...      % Panel horizontal spacer; px
                                 'rbtn_spacer',15,...       % Radio button spacer; px   
                                 'btn_height',30,...        % Push button height; px
                                 'checkbox_height',20,...    % Checkbox height; px
                                 'rbtn_height',20);         % Radio button height; px
           
           obj.booleans = struct('discard_all',false,...
                                 'discard_all_but_selected',false,...
                                 'discard_selected',true,...
                                 'p_update_always',false,...
                                 'p_update_after_fit',true,...
                                 'fit_all',true,...
                                 'fit_selected',false,...
                                 'p_use_original',false,...
                                 'p_use_active',true,...
                                 'p_propagate',false,...
                                 'b_fit_autosave',true,...
                                 'save_as_fitit',false,...
                                 'save_loading_seq',false,...
                                 'export_p_to_table',false,...
                                 'export_as_text',false,...
                                 'save_now_all',true,...
                                 'save_now_selected',false);
           
           obj.last_t_indices = [];
                                     
           obj.table_timer = timer();
           obj.table_timer.Name = 'Table Selection Timer';
           obj.table_timer.StartDelay = 0.3;
           obj.table_timer.TimerFcn = @(tmr,es) obj.view.controller.bl_table_cell_selection_callback();
                     
        end
        
        initialize_gui(obj);
        p = initialize_bfit_panel(obj,panel_width);
        p = initialize_manage_panel(obj,panel_width);
        p = initialize_pupdate_panel(obj,panel_width);
        p = initialize_save_panel(obj,panel_width);
        function set_last_t_indices(obj,indices)
           
            if not(isnumeric(indices) && (isempty(indices) || size(indices,2) == 2))
               
                error('Invalid indices.')
                
            end
            
            obj.last_t_indices = indices;
            
        end
        update_booleans(obj,hObject,callbackdata);
        update_push_buttons(obj);
        
    end % public methods
    
    
end

