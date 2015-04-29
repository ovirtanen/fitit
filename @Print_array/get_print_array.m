function pa = get_print_array(obj)
%GET_PRINT_ARRAY Returns a cell array containing the data to be printed
%   pa = get_print_array() returns a x b cellarray containing

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

cols = obj.op_columns;

% There might be empty cells in cols because the size of the cols is always
% doubled if cols runs out of space.
empty = cellfun(@isempty,cols);
cols(empty) = [];

maxlength = max(cell2mat(cellfun(@size,cols,'UniformOutput',0)));
pa = cell(maxlength,numel(cols));

for i = 1:numel(cols)
    
[r,~] = size(cols{i});

pa(1:r,i) = cols{i};
    
end % for


end

