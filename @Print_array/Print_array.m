classdef Print_array < handle
    %PRINT_ARRAY Class for holding for writing to a file column wise
    %   
    
    % Copyright (c) 2015, Otto Virtanen
    % All rights reserved.
    
    properties (Access = private)
        
        op_columns;             % output columns
        
    end
    
    methods (Access = public)
        
        function obj = Print_array(prealloc)           
            
            obj.op_columns = cell(1,prealloc);
            
        end
       
        add_data(obj,varargin);
        pa = get_print_array(obj);
        
    end
    
    methods (Access = private)
       
        
    end
    
end

