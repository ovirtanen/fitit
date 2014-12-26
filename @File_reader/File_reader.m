classdef (ConstructOnLoad = true) File_reader < handle
    %FILE_READER Reads measurement files to cell arrays.
    %   fr = FileReader(fspec), where fspec is a string specifying the file
    %   type identifier for the files to be opened (see eg. uigetfile
    %   documentation), returns a FileReader instance
    %   
    
    properties (SetAccess = private)
        
        last_load_path;
        filter_spec;
        
    end
    
    
    methods (Access = public)
        
        function obj = File_reader(fSpec)
            
            obj.last_load_path = '';
            
            obj.filter_spec = fSpec; 
            
        end % constructor
        
        m = read_files(obj); 
        p = get_file_paths(obj,fs);
        
        
    end % public methods
    
    methods (Access = private)
        
        [c] = txt2cellstr(obj,fid,eol);
        
    end % private methods
    
end
