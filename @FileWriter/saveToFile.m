function saveToFile(obj,pindarray)
%SAVETOFILE Invokes save dialog and save the specified PrintArrays to a
%file
%   Detailed explanation goes here

if (numel(pindarray) > numel(obj.printArrays)) || (max(pindarray) > numel(obj.printArrays)) || (min(pindarray) < 1)
    
    err = MException('DLS-analyser:InArgError',...
                     'No such PrintArrays.');
    throw(err);
    
end % if

path = obj.getSavePath();

obj.writeToFile(pindarray,path);


end

