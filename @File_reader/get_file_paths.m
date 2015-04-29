function p = get_file_paths(obj,ms)
%GET_FILE_PATHS Opens a standard open file dialog and returns the file paths
%of the selected files
%   p = getFilePaths(ms), where  ms either 'on' or 'off' for
%   MultiSelect, returns cell array of strings p containing the full paths 
%   to the selected files.
%
%   Throws:
%       FitIt:UIException:Open dialog cancelled.

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

[filenames, pathnames, ~] = uigetfile(obj.filter_spec,'Select files for import','MultiSelect',ms,obj.last_load_path);
            
if isequal(filenames,0) || isequal(pathnames,0)
               
    err = MException('FitIt:UIException','Open dialog cancelled.');
    throw(err);
        
end % if
                   
filepaths = strcat(pathnames,filenames);
        
% pathNames is a cell array of strings if there are multiple
% pathnames, otherwise just a string
                        
if iscell(filepaths)
                
    filepaths = sort(filepaths); % sort according to the running number
                
else filepaths = {filepaths}; % only one file selected
                
end % if

obj.last_load_path = pathnames;

p = filepaths;

end

