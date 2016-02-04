function write_line(path,format_spec,data)
%WRITE_LINE Appends lines to a file
%   
%   write_line(obj,path,format_spec,data)
%
% Parameters
% path              File path string
% format_spec       String containing formatting operators
% data              Cell vector holding the data to be written
%
% Throws
% bds_exception

%% Check inputs

if not(ischar(path))
    
    error('Path has to be a string.');
    
elseif not(ischar(format_spec))
    
    error('format_spec has to be a string.');
    
elseif not(isvector(data) && iscell(data))
    
    error('fdata has to be a cell vector.');
    
end

%% Open file for appending

fid = fopen(path,'a');

if fid == -1
   
    msgID = 'WRITE_LINE:Bad_path_string.';
    msg = 'Unable to open file for writing.';
    bps_exception = MException(msgID,msg);
   
    throw(bps_exception);
    
end

%% Write line to file

try 
    
    fprintf(fid,format_spec,data{:});
    
catch ME
    
    fclose(fid);
    rethrow(ME);
    
end % try-catch

fclose(fid);

end

