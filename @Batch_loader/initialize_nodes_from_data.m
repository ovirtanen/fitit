function dns = initialize_nodes_from_data(obj,d,p,qcf)
%INITIALIZE_NODES_FROM_DATA Initialize Data_nodes from data and add them to
%Batch_loader
%
%   initialize_nodes_from_data(d,p,qcf)
%
% Parameters
% d             Cell array containing [j x 2-4] double arrays, where columns
%               are q, intensity, std and smearing parameter sigma.
% p             Cell array of strings, where each entry is the filepath of
%               the corresponding data array in d
% qcf           Conversion factor to convert q (and sigma, if present) to
%               inverse nanometers
%
% Returns
% dns           Data_node_instances sorted in ASCII dictionary order
%
%
% Throws:
% 'FitIt:InvalidInputDataStructure'
% 'FitIt:InvalidInputDataFileNames'
%

bd = cellfun(@(x) isnumeric(x) && (size(x,2)==2 || size(x,2)==3 || size(x,2)==4),d);
bp = cellfun(@(x) ischar(x),p);

if not(numel(bd) == numel(bp))
    
    error('Number of data arrays and filenames is not the same.');

elseif not(all(bd))
    
    index = 1:numel(bd);
    index = index(bd);
    
    err = MException('FitIt:InvalidInputDataStructure',...
                     ['Input data array(s) ' num2str(index) 'are invalid.'] );
    throw(err);
    
elseif not(all(bp))
    
    index = 1:numel(bp);
    index = index(bp);
    
    err = MException('FitIt:InvalidInputDataFileNames',...
                     ['Input data filename(s) ' num2str(index) ' are invalid.'] );
    throw(err);
    
end

% Sort data in ASCII dictionary order in respect to filename

[~,fn,~] = cellfun(@fileparts,p,'UniformOutput',false);
[~, order] = sort(fn);
p = p(order);
d = d(order);

% Initialize Data_node array
dns(numel(d),1) = Data_node();
invalid = false(numel(d),1);

for i = 1 : numel(d)
    
    % negative intensity exception
    try 
        
        ds = obj.model.data_to_data_set(d{i},qcf);
        dns(i) = Data_node(p{i},ds);
        
    catch ME
        
        if strcmp(ME.identifier,'data_to_data_set:invalid_intensity')
           
            invalid(i) = true;
            warning(['Invalid intensity, skipping file ' p{i}]);
            continue;
            
        end % if
        
    end % try-catch
           
end

% Remove any skipped files from the nodes list
dns(invalid) = [];

end

