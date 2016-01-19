function set_fixed_vector(obj,f)
%%SET_FIXED_VECTOR Sets fixed parameters to the state specified in the parameter
%vector for the Distribution instance.
%
%   set_fixed_vector(f)   
%
%   Parameters
%   f           Total FIXED (1) parameter state vector for the Distribution
%               instance.
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

if numel(f) ~= numel(obj.p_ids)
    
    error('Parameter vector does not have the right number of parameters');
    
elseif not(islogical(f))
    
    error('Fixed state vector has to contain booleans.');
    
end

obj.params(:,4) = num2cell(f);

end


