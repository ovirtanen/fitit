function single_load_data(obj,d,fn)
%SINGLE_LOAD_DATA Load one dataset or multiset to Model
%   
%   single_load_data(d,fn) initializes one or more datasets to one Data_node,
%   which will be loaded to Model.
%
% Parameters
% d             Cell array containing [j x 2-4] double arrays, where columns
%               are q, intensity and std ans smearing parameter sigma. If d 
%               contains more than one array, multiset for global fitting 
%               is created automatically
% fn            Cell array of strings, where each entry is the filename of
%               the corresponding data array in d
%
% Rethrows:
% 'FitIt:InvalidInputDataStructure'
% 'FitIt:InvalidInputDataFileNames'
%


% Copyright (c) 2015, 2016, Otto Virtanen
% All rights reserved.

dns = obj.initialize_nodes_from_data(d,fn);

if numel(dns) == 1
    
    obj.nodes = dns;
    obj.active_node = dns;
    
elseif numel(dns) > 1
    
    dns = num2cell(dns);
    dns = Data_node.combine(dns{:});
    
    obj.nodes = dns;
    obj.active_node = dns;
    
else
    
    error('Data loading failed: No Data_nodes created.');
    
end

end

