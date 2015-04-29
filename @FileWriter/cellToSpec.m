function spc = cellToSpec(c,d)
%CELLSTRTOSPEC Maps one dimensional cell array to format spec
%   spc = cellToSpec(c,d), where c is one dimensional cell array containing
%   arbitrary values and d is the delimiter string (e.g. '\t'), prepares a
%   format spec string for values in c separated by d.
%
%   Example: cellToSpec({2 3 'shit'},'\t') returns '%d\t%d\t%s'

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

if min(size(c)) ~= 1
   error('Only one dimensional cellstrings are supported by cellToSpec.'); 
end

cs = cellfun(@class,c,'UniformOutput',0);
cs = cellfun(@mapToSpec,cs,'UniformOutput',0);

spc = strjoin(cs,d);

end

function s = mapToSpec(s)
% Maps strings returned by function class to corresponding strings for
% format spec


switch s
   
    case 'double'
        
        s = '%d';
        
    case 'char'
        
        s = '%s';
        
    otherwise
        
        error('Unknown class')
    
end


end

