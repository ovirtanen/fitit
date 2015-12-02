function [d,p] = import_data(obj,ms)
%IMPORT_DATA Import data using GUI
%
%   d = import_data(ms)
%
%   Parameters
%   ms          Multiselect, either 'on' or 'off'
%
%   Returns
%   d           Cell array, each cell holding a measurement data as three
%               column array
%   p          Cell array, each cell holding a filepath string
%
% Rethrows
% FitIt:InvalidFileStructure:No numeric data recognized.
% FitIt:InvalidFileStructure:Std missing.
% FitIt:InvalidFileStructure:Data structure not recognized.
% FitIt:UIException:Open dialog cancelled.
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

p = obj.fr.get_file_paths(ms);

c = obj.fr.read_files(p);

if ischar(p)
    
    p = {p};
    
end

% FitIt:InvalidFileStructure:Data structure not recognized.
d = obj.raw_data_to_array(c);

end

