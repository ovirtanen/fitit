classdef Controller < handle
    %CONTROLLER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess = private)
        
        model;
        view;
        fr;
        fw;
        
    end
    
    methods (Access = public)
        
        function obj = Controller(m)
            
            obj.model = m;
            
            obj.view = View(obj,m);
            
            obj.fr = File_reader('.txt');
            obj.fw = [];
            
        end % constructor
        
        import_data(obj,ms);
        add_data_set_to_model(obj,ds);
        
        % CALLBACKS
        
        bg_enable_callback(obj,hObject,callbackdata);
        check_box_callback(obj,hObject,callbackdata);
        edit_box_callback(obj,hObject,callbackdata);
        load_data_set_callback(obj,hObject,callbackdata);
        slider_callback(obj,hObject,callbackdata);
        
        
            
    end % public methods
    
end

