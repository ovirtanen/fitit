function obj = combine(varargin)
%COMBINE Combine two or more Data_node instances.
% Data_node instances must not contain any fit related data.
%
% obj = combine(dn1,dn2,...)
%
% Sorts data internally according to file names. NOTE: For simplicity, any
% fit related data will be removed from the node instances.
%
% Parameters
% dn            Data_node instance
%
% Returns
% obj           A composite Data_node instance
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

%% Inarg check

if not(all(cellfun(@(x)isa(x,'Data_node'),varargin)))
   
    error('Input arguments have to be of type Data_node');
        
end

%% Combine the nodes

dna = [varargin{:}];            % Data_node array

arrayfun(@(x)x.remove_parameters(),dna); % for simplicity, remove any existing fit related data

fps = fullfile([dna.filedirs],[dna.filenames]);
[~,order] = sort([dna.filenames]);

dss = [dna.data_sets];
dss = num2cell(dss);

% zip argin
argin = [fps(order);dss(order)];
argin = argin(:);

obj = Data_node(argin{:});

end

