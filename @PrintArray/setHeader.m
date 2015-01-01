function setHeader(obj, header)
%setHeader Sets the header row in PrintArray
%   setHeader(header), where header is a cell array of strings with the
%   same size as the preallocated header, adds the strings in header to the
%   header row

if size(obj.header) ~= size(header)
    err = MException('DLS-analyser:InArgError',...
        'Header array does not have the same dimennsions as the preallocated array.');
    throw(err);
    
elseif not(iscellstr(header))
       
    err = MException('DLS-analyser:InArgError',...
        'Header array does not contain strings.');
    throw(err);
        
end

obj.header(1:end) = header;

end

