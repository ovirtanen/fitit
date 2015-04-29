function add_data(obj,varargin)
%ADD_COLUMN Adds one data column to Print_array
%
%   add_data(data)
%   add_data(data,header)
%   add_data(data, header, units)
%   
%   Adds one column with data and optional header and units strings.
%
%   Parameters:
%   data        an 1-dimensional array or cellarray of data
%   header      column header string
%   units       column units string

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

ind = find(cellfun(@isempty,obj.op_columns),1);

if isempty(ind) % if obj.op_columns is full
    
    s = size(obj.op_columns);
    obj.op_columns = [obj.op_columns cell(s)]; % double the size
    
    ind = max(s) + 1;
    
end

d = varargin{1};

switch iscell(d)
    
    case 1
        
        d = d(:);
    
    case 0
        
        d = num2cell(d(:));

end

switch nargin
   
    case 2
        
        % we're happy
        
    case 3
        
        if ischar(varargin{2})
            d = [varargin(2); d];
        else
            error('Invalid header string');
        end
            
        
    case 4
        
        if all([ischar(varargin{2}) ischar(varargin{3})])
            d = [varargin(2); varargin(3); d];
        else
            error('Invalid header or unit string');
        end
        
        
    otherwise
        
        error('Wrong number of inargs');
    
end

obj.op_columns{ind} = d;


end

