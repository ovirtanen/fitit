function [t,ci] = data_nodes_to_table(dna)
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
% ci        Node indices as cellstr
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

if isempty(dna)
    
    t = [];
    ci = [];
    return;
    
elseif not(isa(dna,'Data_node'))
    
    error('Input has to be of type Data_node.');
    
end

%% Table row indices

% Handle cases where there are multiple filenames in one Data_node
% duplicate rowindices Data_nodes that have multiple Data_sets

[mn,nds] = arrayfun(@(x)x.ismultinode,dna); % [ismultinode, number of datasets]
crowindices = num2cell(1:numel(dna))';

if any(mn)
    
    crowindices(mn) = cellfun(@(x,y)repmat(x,[y 1]),crowindices(mn),num2cell(nds(mn)),'UniformOutput',false);
    
end

ci = vertcat(crowindices{:});
ci = num2cell(ci);
ci = cellfun(@int2str,ci,'UniformOutput',false);

%% Table data

fns = [dna.filenames]';

isfit = repmat({'No'},size(fns));
isfit([dna.isfit]') = {'Yes'};

issaved = repmat({'No'},size(fns));
issaved([dna.issaved]') = {'Yes'};

t = [fns isfit issaved];

end

