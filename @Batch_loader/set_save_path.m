function set_save_path(obj,path)
%SET_SAVE_PATH Check the validity of the save path and assign it to an
%internal variable.
%
%   set_save_path(path)
%
% Parameters
% path          String specifying the save directory
%
% Throws        'SET_SAVE_PATH:Bad_directory' if the directory is not
%               readable and writeable by the user.

% Copyright (c) 2016, Otto Virtanen
% All rights reserved.


if not(ischar(path))

    error('Input has to be a string.');

end

[stat,struc] = fileattrib(path);

if any([stat == 0 struc.UserRead == 0 struc.UserWrite == 0])

    msgID = 'SET_SAVE_PATH:Bad_directory';
    msg = 'Unable to index into array.';
    bd_exception = MException(msgID,msg);
   
    throw(bd_exception);
    
else
    
    obj.save_path = path;
    
end


end

