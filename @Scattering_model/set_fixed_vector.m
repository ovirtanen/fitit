function set_fixed_vector(obj,f)
%SET_FIXED_VECTOR Sets fixed parameters to the state specified in the parameter
%vector for both the Scattering_model and included Distribution instances.
%
%   set_fixed_vector(f)   
%
%   Parameters
%   f           Total FIXED (1) parameter state vector for the Scattering_model
%               and the included Distribution instance.
%

if numel(f) ~= (numel(obj.p_ids) + numel(obj.dist.p_ids))
    
    error('Fixed state vector does not have the right number of parameters');
    
elseif not(islogical(f))
    
    error('Fixed state vector has to contain booleans.');
    
end % if

obj.params(:,4) = num2cell(f(1:numel(obj.p_ids)));

obj.dist.set_fixed_vector(f(numel(obj.p_ids)+1:end));

end
