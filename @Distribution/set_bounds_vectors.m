function set_bounds_vectors(obj,lb,ub)
%SET_PARAM_VECTOR Sets parameter bounds to the values specified in the
%bounds vectors
%   set_param_vector(lb,ub) sets lb(1) and ub(1) to the first '_min' and 
%   '_max' fields, respectively, and so on
%   
%   Paramters
%   lb           Total lower bounds vector for Distribution
%   ub           Total upper bounds vector for Distribution
%

% Copyright (c) 2015-2016, Otto Virtanen
% All rights reserved.

if numel(lb) ~= numel(ub) || numel(lb) ~= numel(obj.p_ids)
    
    error('Bounds vectors do not have the right number of parameters');
    
end

obj.params(:,1) = num2cell(lb);
obj.params(:,3) = num2cell(ub);


end

