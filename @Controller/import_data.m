function [d,p] = import_data(obj,input)
%IMPORT_DATA Import data using GUI
%
%   d = import_data(ms) opens file selection dialog with multiselect
%   setting ms ('on' or 'off').
%   d = import_data(paths) imports directly files specified by the
%   filepaths in cellstr paths.
%
%   Parameters
%   ms          Multiselect, either 'on' or 'off'
%   paths       Cell string, each cell holding a filepath string
%   
%
%   Returns
%   d           Cell array, each cell holding a measurement data as three
%               column array
%   p           Cell array, each cell holding a filepath string
%
% Rethrows
% FitIt:InvalidFileStructure:No numeric data recognized.
% FitIt:InvalidFileStructure:Std missing.
% FitIt:InvalidFileStructure:Data structure not recognized.
% FitIt:UIException:Open dialog cancelled.
%

% Copyright (c) 2015, 2016, Otto Virtanen
% All rights reserved.

switch nargin
        
    case 2
        
        if iscellstr(input)             % paths
            
            p = input;
            
        elseif any(strcmp(input,{'on' 'off'}))  % ms
            
            p = obj.fr.get_file_paths(input); % always returns cellstr
            
            
            
        else
            
            error('Invalid input argument.')
            
        end
    
    otherwise
        
        error('Wrong number of input arguments');
        
end

valid = cellfun(@(x)exist(x,'file'),p);
valid = valid == 2;

if not(all(valid))
   
    error(['Filepath(s)\n' strjoin(p(not(valid)),',\n') ' are invalid.']);
    
end

c = obj.fr.read_files(p);


% FitIt:InvalidFileStructure:Data structure not recognized.
d = obj.raw_data_to_array(c); % cell array of double arrays

% Check for empty arrays
invalid = cellfun(@isempty,d);

if any(invalid)
   
    warning(['Filepath(s)\n' strjoin(p(invalid),',\n') ' resulted in empty arrays.']);
    d(invalid) = [];
    p(invalid) = [];
    
end
    

end

