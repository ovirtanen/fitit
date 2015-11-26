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

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.


[rows,cols] = size(d);

if not(all([cols == 3 rows >= 3]))
   
    error('Invalid data set structure.');
    
end % id

ds = Data_set(d(:,1),d(:,2),d(:,3));

end

