classdef (ConstructOnLoad = true) File_reader < handle
    %FILE_READER Reads measurement files to cell arrays.
    %   fr = FileReader(fspec), where fspec is a string specifying the file
    %   type identifier for the files to be opened (see eg. uigetfile
    %   documentation), returns a FileReader instance
    %   
    
    % Copyright (c) 2015, Otto Virtanen
    % All rights reserved.
    
    properties (SetAccess = private)
        
        last_load_path;
        filter_spec;            % cellstr of file allowd extensions, e.g. {'.txt'}
        last_filter_spec_index; % Filter spec index that was chosen at last import (See Controller)
        
    end
    
    
    methods (Static)
       
        [size,dcoeff,bool] = read_ns_file(filename, startRow, endRow);
        
    end
    
    methods (Access = public)
        
        function obj = File_reader(fSpec)
            
            obj.last_load_path = '';
            
            if iscellstr(fSpec)
            
                obj.filter_spec = fSpec;
            
            elseif ischar(fSpec)
                
                obj.filter_spec = {fSpec};
                
            else
            
                error('Invalid inarg type. Should be str or cellstr.');
                
            end
            
        end % constructor
        
        m = read_files(obj,ms); 
        m = read_ns_files(obj,ms);
        p = get_file_paths(obj,ms);
        
        
    end % public methods
    
    methods (Access = private)
        
        [c] = txt2cellstr(obj,fid,eol);
        
    end % private methods
    
end
