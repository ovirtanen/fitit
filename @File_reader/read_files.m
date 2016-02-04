function m = read_files(obj,p)
%READ_FILES Reads files specified by file paths to cell arrays of strings.
%
%   m = read_files(p), where p is a cell array of strings containing the
%   file paths to the measurement files, returns a cell array with each 
%   cell holding a measurement file as cell array of strings.
%
%   Parameters
%   p       Cell array of strings where each cell contains a file path to a
%           measurement file
%
%   Returns
%   m       Cell array, where each cell has one measurement file as cell array of strings 
%
%   Rethrows: 
%       FitIt:UIException:Open dialog cancelled.

% Copyright (c) 2015, 2016, Otto Virtanen
% All rights reserved.

if not(iscellstr(p))
   
    error('Invalid input argument.');
    
end

m = cell(numel(p),1); % initialize for speed

for i = 1 : numel(p)
    
    fid = fopen(p{i});
    
    try
        m{i} = obj.txt2cellstr(fid,[char(13) char(10)]);
        
    catch ME
        
        success = fclose(fid);
        
        if success == -1
           warning(['Unable to close file ' p{i}]); 
        end
        
        rethrow(ME);
       
    end
    
    success = fclose(fid);
    
    if success == -1
           warning(['Unable to close file ' p{i}]); 
    end
    
end % for


end



