function t = data_nodes_to_table(dna)
%DATA_NODES_TO_TABLE Converts information in Data_nodes to format
%presentable in Batch_loader GUI table
%  
%   t = data_nodes_to_table(dna)
%
% Parameters
% dna
%
% Returns
% t         Cell array holding the table data [i x 3] cell. If dna is
%           empty, t will be []
%
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

if isempty(dna)
    
    t = [];
    return;
    
elseif not(isa(dna,'Data_node'))
    
    error('Input has to be of type Data_node.');
    
end
    
fns = [dna.filenames]';

isfit = repmat({'No'},size(fns));
isfit([dna.isfit]') = {'Yes'};

issaved = repmat({'No'},size(fns));
issaved([dna.issaved]') = {'Yes'};

t = [fns isfit issaved];

end

