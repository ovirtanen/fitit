function dns = initialize_nodes_from_data(obj,d,fn)
%INITIALIZE_NODES_FROM_DATA Initialize Data_nodes from data and add them to
%Batch_loader
%
%   initialize_nodes_from_data(d)
%
% Parameters
% d             Cell array containing [j x 3] double arrays, where columns
%               are q, intensity and std.
% fn            Cell array of strings, where each entry is the filename of
%               the corresponding data array in d
% Returns
% dns           Data_node_instances sorted in ASCII dictionary order
%
%
% Throws:
% 'FitIt:InvalidInputDataStructure'
% 'FitIt:InvalidInputDataFileNames'
%

bd = cellfun(@(x) isnumeric(x) && size(x,2)==3,d);
bfn = cellfun(@(x) ischar(x),fn);

if not(numel(bd) == numel(bfn))
    
    error('Number of data arrays and filenames is not the same.');

elseif not(all(bd))
    
    index = 1:numel(bd);
    index = index(bd);
    
    err = MException('FitIt:InvalidInputDataStructure',...
                     ['Input data array(s) ' num2str(index) 'are invalid.'] );
    throw(err);
    
elseif not(all(bfn))
    
    index = 1:numel(bfn);
    index = index(bfn);
    
    err = MException('FitIt:InvalidInputDataFileNames',...
                     ['Input data filename(s) ' num2str(index) ' are invalid.'] );
    throw(err);
    
end

% Sort data in ASCII dictionary order

[fn, order] = sort(fn);
d = d(order);

% Initialize Data_node array
dns(numel(d),1) = Data_node();

for i = 1 : numel(d)
          
    ds = obj.model.data_to_data_set(d{i});
    dns(i) = Data_node(fn{i},ds);
           
end

end

