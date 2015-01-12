function writeToFile(obj,pindarray, path)
%WRITETOFILE Writes the specified PrintArrays to a text file
%   writeToFile(pindarray, path), where pindarray is an index array of
%   PrintArrays (e.g. [1 2 3] will write 3 PrintArrays in order 1-2-3),
%   path is the file path to the file to be written, writes the contents of
%   the specified PrintArray instances to the file.
%
% Throws: 

fid = fopen(path,'w');

for i = pindarray
    
    try
        
        parrayToFile(obj.printArrays(i));
        
    catch ME
        
        fclose('all');
        
        rethrow(ME);
        
    end % try-catch
    
end % for

fclose('all');

function parrayToFile(parray)
% Helper function to iterate through each parray

pa = parray.get_print_array();

[length,~] = size(pa);

for j = 1:length
    
    d = pa(j,1:end);
    
    fprintf(fid, [obj.cellToSpec(d,'\t') char(13) char(10)], d{1,1:end});
    
end % for

fprintf(fid, '%s', [char(13) char(10)]); % empty row

end % parrayToFile


end

