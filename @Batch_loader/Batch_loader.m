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
        
        function add_data_nodes(obj,nodes)
            
            if isempty(nodes) % All but selected was chosen but there is only one dataset
                
                return;
                
            elseif not(isa(nodes,'Data_node'))
                
                error('Invalid input argument.');
                
            end
            
            old_nodes = obj.nodes(:);
            nodes = [old_nodes; nodes(:)];
            
            obj.nodes = Data_node.name_sort(nodes);
            
            
        end
        
        batch_load_data(obj,d,fn); 
        dns = initialize_nodes_from_data(obj,d,fn);
        function remove_data_nodes(obj,nn)
           
            if isempty(nn) % All but selected was chosen but there is only one dataset
                
                return;
                
            end
            
            if not(min(nn) >= 1 && max(nn) <= numel(obj.nodes))
               
                error('Invalid node indices');
                
            end

            if numel(nn) == numel(obj.nodes) || (numel(obj.nodes) == 1 && nn == 1)
                
                obj.nodes = [];
                
            else
            
                obj.nodes(nn) = [];
                
            end
            
            % Sort just to be sure
            obj.nodes = Data_node.name_sort(obj.nodes);
            
        end     
        function set_active_node(obj,ani)
           
            if isempty(ani) || (numel(ani) == 1 && ani > 0 && ani <= numel(obj.nodes))
                
                obj.active_node_index = ani;
                obj.active_node = obj.nodes(ani);
                
            end
            
        end
        single_load_data(obj,d,fn);
        update_table(obj);
       
    end
    
end

