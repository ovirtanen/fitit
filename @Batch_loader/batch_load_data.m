function batch_load_data(obj,d,fn,qcf,ls,varargin)
%BATCH_LOAD_DATA Load multiple Data_nodes to Batch_loader
%   
% batch_load_data(d,fn,qcf) initializes multiple datasets from data that will 
% be loaded to different Data_nodes. Data_nodes are sorted alphabetically
% and the first one will be loaded to Model.
% batch_load_data(d,fn,qcf,loadseq) uses load sequence to group datasets to
% Data_node instances
%
% If there are Data_nodes already loaded, new Data_nodes will be added and
% all the Data_nodes will be sorted according to ASCII alphabet.
%
% Parameters
% d             Cell array containing [j x 2-4] double arrays, where columns
%               are q, intensity, std and smearing parameter sigma. (NOTE:
%               not sigma2) If d contains more than one array, multiple 
%               nodes are created.
% fn            Cell array of strings, where each entry is the filename of
%               the corresponding data array in d
% qcf           Conversion factor to convert q (and sigma, if present) to
%               inverse nanometers
% ls            Line skip, how many data lines to skip when initializing
%               data_sets. 
% loadseq       Not yet implemented
%
% Rethrows:
% 'FitIt:InvalidInputDataStructure'
% 'FitIt:InvalidInputDataFileNames'
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.


if nargin == 6
   
    % check load sequence
    warning('Load sequencing not implemented yet');
    
elseif nargin > 6 
    
    error('Too many input arguments.');
    
end

if ls ~= 0
   
    warning(['Line skip of ' num2str(ls) ' is in use for data import.']);
    
end

dns = obj.initialize_nodes_from_data(d,fn,qcf,ls);

if isempty(obj.nodes)
    
    obj.nodes = dns;
    obj.active_node = [];
    
else
    
    % If someone wants to add already loaded data they can do it.
    
    dns = [obj.nodes; dns];
    obj.nodes = Data_node.name_sort(dns);
    obj.active_node = [];
    
end

end

