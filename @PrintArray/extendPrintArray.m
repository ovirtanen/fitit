function extendPrintArray(obj)
%EXTENDPRINTARRAY Doubles the data rows of the PrintArray
%   

[r,c] = size(obj.data);

extension = cell(r,c);

obj.data = [obj.data; extension];


end

