function ds = data_to_data_set(d)
%DATA_TO_DATA_SET Initialize Data_set from three-column double array
%   
%   ds = data_to_data_set(d)
%
% Parameters
% d             Three column double array, with columns q, intensity and
%               std
%
%
%

% Copyright (c) 2015, 2016, Otto Virtanen
% All rights reserved.


[rows,cols] = size(d);

if rows < 3 || not(any([cols == 2 cols == 3 cols == 4]))
   
    error('Invalid data set structure.');
    
end % if

switch cols
    
    case 2
        
        ds = Data_set(d(:,1),d(:,2));
   
    case 3
        
        ds = Data_set(d(:,1),d(:,2),d(:,3));
        
    case 4
        
        ds = Data_set(d(:,1),d(:,2),d(:,3),d(:,4).^2);
        
    otherwise
        
        error('Invalid data set structure.');
        
end

end

