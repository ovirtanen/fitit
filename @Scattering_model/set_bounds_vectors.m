function set_bounds_vectors(obj,lb,ub)
%SET_BOUNDS_VECTORS Sets upper and lower bounds to the values specified in 
%the bounds vectors for both the Scattering_model and included Distribution 
%instances
%   set_bounds_vectors(lb,ub) sets lb(1) and ub(1) to the first '_min' and
% '_max' fields, and so on, rest of the bounds are forwarded to the
%   Distribution instance.
%   
%   Parameters
%   lb          Total lower bounds vector for the Scattering_model and the
%               included Distribution instance
%   ub          Total upper bounds vector for the Scattering_model and the
%               included Distribution instance
%

if numel(lb) ~= numel(ub) || numel(lb) ~= (numel(obj.p_ids) + numel(obj.dist.p_ids))
    
    error('Bound vectors do not have the right number of parameters');
    
end % if

obj.params(:,1) = num2cell(lb(1:numel(obj.p_ids)));
obj.params(:,3) = num2cell(ub(1:numel(obj.p_ids)));

obj.dist.set_bounds_vectors(lb(numel(obj.p_ids)+1:end),ub(numel(obj.p_ids)+1:end));

end

