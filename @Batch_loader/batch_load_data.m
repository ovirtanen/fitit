function batch_load_data(obj,d,fn,qcf,varargin)
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
% d             Cell array containing [j x 3] double arrays, where columns
%               are q, intensity and std. If d contains more than one
%               array, multiset for global fitting is created automatically
% fn            Cell array of strings, where each entry is the filename of
%               the corresponding data array in d
% qcf           Conversion factor to convert q (and sigma, if present) to
%               inverse nanometers
% loadseq       Not yet implemented
%
% Rethrows:
% 'FitIt:InvalidInputDataStructure'
% 'FitIt:InvalidInputDataFileNames'
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.


if nargin == 5
   
    % check load sequence
    warning('Load sequencing not implemented yet');
    
elseif nargin > 5 
    
    error('Too many input arguments.');
    
end

dns = initialize_nodes_from_data(obj,d,fn,qcf);

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

