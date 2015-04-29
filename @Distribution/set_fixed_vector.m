function set_fixed_vector(obj,p)
%SET_FIXED_VECTOR Sets fixed state to the values specified in the parameter
%vector
%
%   set_fixed_vector(p)
%   
%   Paramters
%   p           Parameter vector
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

if numel(p) ~= numel(obj.p_ids)
    
    error('Parameter vector does not have the right number of parameters');
    
elseif not(all(p == 1 | p == 0))
    
    error('Fixed state vector has to contain booleans.');
    
end

obj.params(:,4) = num2cell(p);

end


