function addRow(obj,row)
%ADDROW Adds a row to the PrintArray
%   addRow(row), where row is a cell array of values with obj.nVar columns,
%   adds row to the data array of the PrintArray. 


if not(all(size(row) == [1 obj.nVar]) | all(size(row) == [obj.nVar 1]))

    err = MException('DLS-analyser:InArgError',...
        'Input has wrong dimensions.');
    throw(err);
    
elseif not(iscell(row))
    
    err = MException('DLS-analyser:InArgError',...
        'Input must be a cell array.');
    throw(err);
    
end

[maxr, ~] = size(obj.data);

if obj.rowIndex > maxr
   
    obj.extendPrintArray();
    
end

obj.data(obj.rowIndex,1:end) = row;
obj.rowIndex = obj.rowIndex + 1;

end

