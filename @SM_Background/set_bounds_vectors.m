function set_bounds_vectors(obj,lb,ub)
%SET_BOUNDS_VECTORS Sets bounds to the values specified in the bounds
%vectors for SM_background
%   set_bounds_vectors(lb,ub) sets lb(1) and ub(1) to the first '_min' field
%   and '_max' field and so on. 
%   
%   Parameters
%   lb           Total lower bounds vector for SM_Background
%   ub           Total upper bounds vector for SM_Background
%

e = obj.enabled;

if numel(lb) ~= (numel(e(e == true)))
    
    numel(e == true)
    numel(p)
    error('Parameter vector does not have the right number of parameters');
    
end % if

ind = 1:numel(e);
obj.params(ind(e == true),2) = num2cell(p);
end

