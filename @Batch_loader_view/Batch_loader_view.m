classdef Batch_loader_view
    %BATCH_LOADER_VIEW View class for the Batch_loader GUI
    % 
    
    
    properties (SetAccess = private)
        
        gui;
        view;
        
        pupdate_panel;     % Parameter update panel
        bfit_panel;        % Batch fit panel
        manage_panel;      % Manage data panel
        save_panel;        % Save panel
        
    end
    
    methods (Access = public)
        
        function obj = Batch_loader_view(view)
            
            obj.view = view;
            
        end
        
        fig = initialize_gui(obj);
        
    end
    
end

