function dna = name_sort(dna)
%NAME_SORT Sorts an array of Data_node instances according to their file
%names
%   dna = name_sort(dna)
%
% Multinodes are sorted according to their first file name.
%
%
% Parameters 
% dna           Data_node array
%
% Returns 
% dna           Data_node array sorted according to the file names

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.


fns = arrayfun(@(x)x.filenames(1),dna);
[~,order] = sort(fns);
dna = dna(order);

end

