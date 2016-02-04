function dna = ungroup(dn)
%UNGROUP Ungroups Data_node consisting of multiple Data_sets
%   
%   dna = ungroup(dn)
%
% Parameters
% dn            Data_node instance
%
% Returns
% dna           Data_node array consisting of decomposed Data_nodes in
%               uninitialized state
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

if not(isa(dn,'Data_node'))
   
    error('Input argument is not a Data_node instance.');
    
end

[b,n] = dn.ismultinode();

if not(b)
    
    dna = dn;
    return;
    
end

% Initialize Data_node array
dna(n,1) = Data_node();

for i = 1:n
   
    dni = Data_node(fullfile(dn.filedirs{i},dn.filenames{i}),dn.data_sets(i));
    dna(i) = dni;
    
end

end

