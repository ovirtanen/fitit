function p = get_param_vector(obj)
%GET_PARAM_VECTOR Returns the parameter vector of the distribution instance
%   
%   p = get_param_vector()
%
%   Returns
%   p           Parameter vector with p = params(:,2)
%                     
%

p = cell2mat(obj.params(:,2));


end

