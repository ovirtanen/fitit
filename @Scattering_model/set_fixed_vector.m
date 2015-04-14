function set_fixed_vector(obj,p)
%SET_FIXED_VECTOR Sets fixed parameters to the state specified in the parameter
%vector for both the Scattering_model and included Distribution instances
%
%   set_fixed_vector(p)   
%
%   Parameters
%   p           Total fixed state vector for the Scattering_model and the
%               included Distribution instance
%

if numel(p) ~= (numel(obj.p_ids) + numel(obj.dist.p_ids))
    
    error('Fixed state vector does not have the right number of parameters');
    
elseif not(all(p == 1 | p == 0))
    
    error('Fixed state vector has to contain booleans.');
    
end % if

obj.params(:,4) = num2cell(p(1:numel(obj.p_ids)));

obj.dist.set_fixed_vector(p(numel(obj.p_ids)+1:end));

end
