function pind = addParray(obj, pa)
%ADDPARRAY Adds a PrintArray to FileWriter
%   pind = addParray(pa, nVar) adds an Print_array instance pa to the
%   FileWriter. Returns Print_array index pind for further reference to 
%   this instance.

pind = obj.parrayIndex;
obj.printArrays = [obj.printArrays pa];
obj.parrayIndex = obj.parrayIndex + 1;

end

