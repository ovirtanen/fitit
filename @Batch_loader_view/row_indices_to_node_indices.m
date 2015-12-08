function ind = row_indices_to_node_indices(obj,indices)
%ROW_INDICES_TO_NODE_INDICES Reads row indices from Batch Loader View GUI
%uitable and maps them to unique Data_node indices
%   
%   ind = row_indices_to_node_indices()
%
% Parameters
% indices       uitable cell selection indice matrix
%
%
% Returns
% ind           vector of node indices
%
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

if isempty(indices)
    
    ind = [];
    return;
    
elseif size(indices,2) ~=2 || indices(:,2) ~= 1
    
    error('Invalid indices.');
    
end

rn = obj.file_table.RowName;

if not(iscellstr(rn) || size(rn,2) >= size(rn,1))
   error('Invalid output from uitable RowName property.');
end

rn = str2double(obj.file_table.RowName); % RowName is a cellstr
ind = rn(indices(:,1));
ind = unique(ind);

end

