function m = read_files(obj,ms)
%READ_FILES Reads files specified by the user in an open dialog to cell
%arrays of strings.
%   m = read_files(ms) opens an open dialog asking for the files to be opened
%   and returns a cell array with each cell holding a measurement file as
%   cell array of strings. ms is either 'on' or 'off' for multiselect.
%
%   Returns
%   m       Cell array, where each cell has one measurement file as cell array of strings 
%
%   Rethrows: 
%       FitIt:UIException:Open dialog cancelled.

p = obj.get_file_paths(obj.filter_spec,ms);

m = cell(length(p),1); % initialize for speed

fids = cellfun(@fopen,p);

for i = 1 : length(fids)
    
    m{i} = obj.txt2cellstr(fids(i),[char(13) char(10)]);
    
end % for

fclose('all');

end

