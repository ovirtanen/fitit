classdef Batch_loader < handle
    %BATCH_LOADER Class for managing multiple simultaneously loaded
    %Data_nodes
    %   Detailed explanation goes here
    
    properties (SetAccess = private)
        
        nodes;
        active_node;
        active_node_index;
        
    end
    
    properties (Access = private)
       
        model; 
        
    end
    
    methods(Static)
       
        [t,ci] = data_nodes_to_table(obj,dna);
        
    end
    
    methods (Access = public)
        
        function obj = Batch_loader(model)
           
            obj.model = model;             
            obj.nodes = [];
            obj.active_node = [];
                   
        end % Constructor
        
        % OTHER PUBLIC
        
        batch_load_data(obj,d,fn); 
        dns = initialize_nodes_from_data(obj,d,fn);
        function set_active_node(obj,ani)
           
            if numel(ani) == 1 && ani > 0 && ani <= numel(obj.nodes)
                
                obj.active_node_index = ani;
                obj.active_node = obj.nodes(ani);
                
            end
            
        end
        single_load_data(obj,d,fn);
        update_table(obj);
       
    end
    
end

