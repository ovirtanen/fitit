function dns = initialize_nodes_from_data(obj,d,fn)
%INITIALIZE_NODES_FROM_DATA Initialize Data_nodes from data and add them to
%Batch_loader
%
%   initialize_nodes_from_data(d)
%
% Parameters
% d             Cell array containing [j x 3] double arrays, where columns
%               are q, intensity and std.
% Returns
% dns           Data_node_instances
%
%
% Throws:
% 'FitIt:InvalidInputDataStructure'
% 'FitIt:InvalidInputDataFileNames'
%

bd = cellfun(@(x) isnumeric(x) && size(x,2)==3,d);
bfn = cellfun(@(x)iscellstr && numel(x)==numel(d),fn);

if not(all(bd))
    
    index = 1:numel(bd);
    index = index(bd);
    
    err = MException('FitIt:InvalidInputDataStructure',...
                     ['Input data array(s) ' num2str(index) 'are invalid.'] );
    throw(err);
    
elseif not(all(bfn))
    
    index = 1:numel(bd);
    index = index(bd);
    
    err = MException('FitIt:InvalidInputDataFileNames',...
                     ['Input data filename(s) ' num2str(index) 'are invalid.'] );
    throw(err);
    
end

dns = Data_node(numel(d),1);

for i = 1 : numel(d)
          
    ds = obj.model.data_to_data_set(d{i});
    dns(i) = Data_node(fn(i),ds(i));
           
end

end

