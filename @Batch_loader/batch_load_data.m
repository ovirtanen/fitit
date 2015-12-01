function batch_load_data(obj,d,fn,varargin)
%BATCH_LOAD_DATA Load multiple Data_nodes to Batch_loader
%   
% batch_load_data(d,fn) initializes multiple datasets from data that will 
% be loaded to different Data_nodes. Data_nodes are sorted alphabetically
% and the first one will be loaded to Model.
% batch_load_data(d,fn,loadseq) uses load sequence to group datasets to
% Data_node instances
%
% Parameters
% d             Cell array containing [j x 3] double arrays, where columns
%               are q, intensity and std. If d contains more than one
%               array, multiset for global fitting is created automatically
% fn            Cell array of strings, where each entry is the filename of
%               the corresponding data array in d
% loadseq       Not yet implemented
%
% Rethrows:
% 'FitIt:InvalidInputDataStructure'
% 'FitIt:InvalidInputDataFileNames'
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.


if nargin == 4
   
    % check load sequence
    warning('Load sequencing not implemented yet');
    
elseif nargin > 4
    
    error('Too many input arguments.');
    
end

dns = initialize_nodes_from_data(obj,d,fn);

obj.nodes = dns;
obj.active_node = dns(1);

end

