classdef (ConstructOnLoad = true) FileWriter < handle
    %FILEWRITER Class for holding and managing PrintArray instances
    %obj = FileWriter(cntrlr,fspec), where cntrlr is the calling Controller
    %instance and fspec the filterspec string, initializes a new FileWriter
    %instance.
    
    properties (SetAccess = private)
       
        printArrays;
        
    end
    
    
    properties (Access = private)
        
        cntrlr;
        filterspec;
        parrayIndex;
        lastSavePath;
        
    end
    
    methods (Access = public)
        
        function obj = FileWriter(cntrlr,fspec)
           
           obj.cntrlr = cntrlr;
           obj.filterspec = fspec;
           
           obj.parrayIndex = 1;
           
           % set the default save path to the last load path if exists
           
           llp = obj.cntrlr.filereader.lastLoadPath;
           
           if exist(llp,'dir') == 7
               
               obj.lastSavePath = obj.cntrlr.filereader.lastLoadPath;
           
           else
            
               obj.lastSavePath = '';
               
           end % if
            
        end % constructor
        
        pind = addParray(obj,prealloc,nVar);
        saveToFile(obj,pindarray)
        
    end
    
    methods (Access = private)
        
       t = parrayToTable(obj,pind);
       p = getSavePath(obj);
       writeToFile(obj,pindarray,path);
        
    end
    
end

