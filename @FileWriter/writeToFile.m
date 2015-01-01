function writeToFile(obj,pindarray, path)
%WRITETOFILE Writes the specified PrintArrays to a text file
%   writeToFile(pindarray, path), where pindarray is an index array of
%   PrintArrays (e.g. [1 2 3] will write 3 PrintArrays in order 1-2-3),
%   path is the file path to the file to be written, writes the contents of
%   the specified PrintArray instances to the file.
%
% Throws: DLS-analyser:IOException:Could not write to the specified file.

fid = fopen(path,'w');

for i = pindarray
    
    try
        
        parrayToFile(obj.printArrays(i));
        
    catch ME
        
        fclose('all');
        
        err = MException('DLS-analyser:IOException',...
                         'Could not write to the specified file.');
        throw(err);
        
    end % try-catch
    
end % for

fclose('all');

function parrayToFile(parray)
% Helper function to iterate through each parray

% header
fprintf(fid, [repmat('%s\t',1,parray.nVar-1) '%s' char(13) char(10)], parray.header{1,1:end});

% units
fprintf(fid, [repmat('%s\t',1,parray.nVar-1) '%s' char(13) char(10)], parray.units{1,1:end});

% data

[length,~] = size(parray.data);

for j = 1:length
    
    fprintf(fid, [repmat('%d\t',1,parray.nVar-1) '%d' char(13) char(10)], parray.data{j,1:end});
    
end % for

fprintf(fid, '%s', [char(13) char(10)]); % empty row

end % parrayToFile


end

