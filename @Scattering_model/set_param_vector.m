function set_param_vector(obj,p)
%SET_PARAM_VECTOR Sets parameters to the values specified in the parameter
%vector for both the Scattering_model and included Distribution instances
%   set_param_vector(p) sets p(1) to the first '_val' field, p(2) to the
%   second and so on, rest of the parameters are forwarded to the
%   Distribution instance.
%   
%   Parameters
%   p           Total parameter vector for the Scattering_model and the
%               included Distribution instance
%

if numel(p) ~= (numel(obj.p_ids) + numel(obj.dist.p_ids))
    
    error('Parameter vector does not have the right number of parameters');
    
end % if

obj.params(:,2) = num2cell(p(1:numel(obj.p_ids)));

obj.dist.set_param_vector(p(numel(obj.p_ids)+1:end));

end

