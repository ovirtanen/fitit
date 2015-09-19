function ntarget = assign(target,value,varargin)
%ASSIGN Assigns value to the property of the target
%
% target = assign(target,value)
% target = assign(target,value,propertyName,subPropertyName,...)
%
% Parameters
% target            Root target of the assignment, e.g. class instance
%                   or struct
% value             Value to be assigned
% propertyName      Name of the property
% subPropertyName   Property of the property, if the the previous property
%                   is structured
%
% Returns
% target            A new instance of root target with the assignment
%
% Examples
%
% s = {struct('Field1',1,'Field2',2)};
% s = repelem(s,5,1);
% s = cellfun(@(x)assign(x,3,'Field1'),s);
% [s.Field1]
%   ans =
%     3     3     3     3     3

% Copyright (c) 2015, Otto Virtanen
% All rights reserved

ntarget = target;

switch numel(varargin)
   
    case 0
        
        ntarget = value;
        return;
        
    case 1
        
        ntarget.(varargin{1}) = value;
        return;
        
    otherwise
        
        ntarget.(varargin{1}) = Lib.assign(ntarget.(varargin{1}),value,varargin{2:end});
        return;
    
end


end

