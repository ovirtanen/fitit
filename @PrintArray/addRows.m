function addRows(obj,rows)
%ADDROWS Adds multiple rows to PrintArray simultaneously 
%   addRows(row), where row is a cell array of values with obj.nVar columns,
%   adds all the rows in the array to the data array of the PrintArray. 
if not(iscell(rows))
    
    err = MException('FitIt:InArgError',...
        'Input must be a cell array.');
    throw(err);
    
end % if

[maxr,~] = size(rows);

for i = 1:maxr

    obj.addRow(rows(i,:));
    
end % for

end

