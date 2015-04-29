function p = getSavePath(obj)
%GETSAVEPATH Returns a user specified file path for exporting data
%  p = getSavePath() shows the default save dialog and returns the path
%  chosen by the user
%
%  THROWS
%   DLS_analyzer:UIException:Save dialog cancelled.

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

[filename, pathname, ~] = uiputfile(obj.filterspec,'Specify save destination',obj.lastSavePath);
            
if isequal(filename,0) || isequal(pathname,0)
               
    err = MException('DLS_analyzer:UIException','Save dialog cancelled.');
    throw(err);
        
end % if
                   
filepath = strcat(pathname,filename);
            
obj.lastSavePath = filepath;

p = filepath;

end

