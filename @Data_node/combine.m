function obj = combine(varargin)
%COMBINE Combine two or more Data_node instances.
% Data_node instances must not contain any fit related data.
%
% obj = combine(dn1,dn2,...)
%
% Sorts data internally according to file names.
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
    
elseif not(all(cellfun(@(x)isempty(x.s_model_name),varargin)))
    
    error('Data_node instances must not contain fit related data.');
    
elseif not(all(cellfun(@(x)isempty(x.dist_name),varargin)))
    
    error('Data_node instances must not contain fit related data.');
    
elseif not(all(cellfun(@(x)all(x.bg_enabled == 0),varargin)))   
    
    error('Data_node instances must not contain fit related data.');
    
elseif not(all(cellfun(@(x)all(x.sls_br_enabled == 0),varargin)))
    
    error('Data_node instances must not contain fit related data.');
    
elseif not(all(cellfun(@(x)isnan(x.total_param_vector),varargin)))
    
    error('Data_node instances must not contain fit related data.');
    
end

%% Combine the nodes

dna = [varargin{:}];            % Data_node array

fps = fullfile([dna.filedirs],[dna.filenames]);
[~,order] = sort([dna.filenames]);

dss = [dna.data_sets];
dss = num2cell(dss);

% zip argin
argin = [fps(order);dss(order)];
argin = argin(:);

obj = Data_node(argin{:});

end

