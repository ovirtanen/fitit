function t = parrayToTable(obj,pind)
%PARRAYTOTABLE Returns a PrintArray instance as MATLAB table
%   t = parrayToTable(pind) returns the PrintArray instance specified by
%   the identifier pind as a MATLAB table


pa = obj.printArrays(pind);

t = cell2table(pa.data);
t.Properties.VariableNames = pa.header;
t.Properties.VariableUnits = pa.units;

end

