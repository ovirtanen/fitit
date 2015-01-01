function pind = addParray(obj, prealloc, nVar)
%ADDPARRAY Adds a PrintArray to FileWriter
%   pind = addParray(prealloc, nVar) adds an empty PrintArray instance to
%   FileWriter with prealloc rows and  nVar columns for variables. Returns
%   PrintArray index pind for further reference to this instance.

pind = obj.parrayIndex;
pa = PrintArray(prealloc,nVar);

obj.printArrays = [obj.printArrays pa];
obj.parrayIndex = obj.parrayIndex + 1;

end

