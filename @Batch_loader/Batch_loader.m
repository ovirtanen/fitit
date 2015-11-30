classdef Batch_loader < handle
    %BATCH_LOADER Class for managing multiple simultaneously loaded
    %Data_nodes
    %   Detailed explanation goes here
    
    properties (SetAccess = private)
        
        nodes;
        active_node;
        
    end
    
    properties (Access = private)
       
        model;
        active_node_index;
        
    end
    
    methods (Access = public)
        
        function obj = Batch_loader(model)
           
            obj.model = model;             
            obj.nodes = [];
            obj.active_node = [];
                   
        end % Constructor
        
        % OTHER PUBLIC
        
        initialize_nodes_from_data(obj);
        set_active_node(obj,ani)
        
        
    end
    
end

