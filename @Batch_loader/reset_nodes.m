function reset_nodes(obj)
%RESET_NODES Deletes all model parameter data from all the Data_node
%instances
%   
%   reset_nodes()
%

if isempty(obj.nodes)
    
    return;
    
end

for i = 1:numel(obj.nodes)

   obj.nodes(i).remove_parameters();
    
end


end

