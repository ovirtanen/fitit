classdef (ConstructOnLoad = true) FileWriter < handle
    %FILEWRITER Class for holding and managing PrintArray instances
    %obj = FileWriter(cntrlr,fspec), where cntrlr is the calling Controller
    %instance and fspec the filterspec string, initializes a new FileWriter
    %instance.
    
    properties (SetAccess = private)
       
        printArrays;
        
    end
    
    
    properties (Access = private)
        
        controller;
        filterspec;
        parrayIndex;
        lastSavePath;
        
    end
    
    methods(Static)
       
       s =  cellToSpec(c,d);
        
    end
    
    methods (Access = public)
        
        function obj = FileWriter(c,fspec)
           
           obj.controller = c;
           obj.filterspec = fspec;
           
           obj.parrayIndex = 1;
           
           % set the default save path to the last load path if exists
           
           llp = obj.controller.fr.last_load_path;
           
           if exist(llp,'dir') == 7
               
               obj.lastSavePath = llp;
           
           else
            
               obj.lastSavePath = '';
               
           end % if
            
        end % constructor
        
        pind = addParray(obj,printarray);
        deleteParrays(obj);
        saveToFile(obj,pindarray);
        writeToFile(obj,pindarray,path);
        
    end
    
    methods (Access = private)
        
       p = getSavePath(obj);
       
    end
    
end

