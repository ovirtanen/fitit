classdef PrintArray < handle
    %PRINTARRAY Holds header and data for writing to a file
    %   
    
    properties (SetAccess = private)
        
        header;
        units;
        data;
        rowIndex;
        nVar;
        
    end
    
    methods (Access = public)
        
        function obj = PrintArray(rows,cols)           
            
            obj.nVar = cols;
            obj.header = cell(1,obj.nVar);
            obj.units = cell(1,obj.nVar);
            obj.data = cell(rows,obj.nVar);
            obj.rowIndex = 1;
            
        end
       
        setHeader(obj,header);
        setUnits(obj,unts);
        addRow(obj,row);
        addRows(obj,rows);
        
    end
    
    methods (Access = private)
       
        extendPrintArray(obj)
        
    end
    
end

