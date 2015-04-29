function set_param_vector(obj,p)
%SET_PARAM_VECTOR Sets parameters to the values specified in the parameter
%vector
%   set_param_vector(p) sets p(1) to the first '_val' field, p(2) to the
%   second and so on.
%   
%   Paramters
%   p           Parameter vector
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

if numel(p) ~= numel(obj.p_ids)
    
    error('Parameter vector does not have the right number of parameters');
    
end

obj.params(:,2) = num2cell(p);

end

