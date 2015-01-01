function setUnits(obj,unts)
%SETUNITS Sets the units row in PrintArray
%   setUnits(unts), where unts is a cell array of strings with the
%   same size as the preallocated header, adds the strings in unts to the
%   units row


if size(obj.header) ~= size(unts)
    err = MException('DLS-analyser:InArgError',...
        'Units array does not have the same dimennsions as the preallocated array.');
    throw(err);
    
elseif not(iscellstr(unts))
       
    err = MException('DLS-analyser:InArgError',...
        'Units array does not contain strings.');
    throw(err);
        
end

obj.units(1:end) = unts;


end

