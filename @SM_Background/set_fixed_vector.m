function set_fixed_vector(obj,f)
%SET_FIXED_VECTOR Sets fixed parameters to the state specified in the fixed
%vector for both the SM_Background instance.
%
%   set_fixed_vector(f)   
%
%   Parameters
%   f           Total FIXED (1) parameter state vector for the
%               SM_Background instance.

% Copyright (c) 2015,2016, Otto Virtanen
% All rights reserved.

e = obj.enabled;

if numel(f) ~= (numel(e(e == true)))
    
    error('Parameter vector does not have the right number of parameters');
    
elseif not(islogical(f))
    
    error('Fixed state vector has to contain booleans.');    
    
end % if

ind = 1:numel(e);
obj.params(ind(e == true),4) = num2cell(f);

end

