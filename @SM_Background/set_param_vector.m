function set_param_vector(obj,p)
%SET_PARAM_VECTOR Sets parameters to the values specified in the parameter
%vector for SM_background
%   set_param_vector(p) sets p(1) to the first '_val' field
%   
%   Parameters
%   p           Total parameter vector for SM_Background
%

e = obj.enabled;

if numel(p) ~= (numel(e(e == true)))
    
    error('Parameter vector does not have the right number of parameters');
    
end % if

ind = 1:numel(e);
obj.params(ind(e == true),2) = num2cell(p);

end
