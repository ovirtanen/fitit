function set_param_vector(obj,lb,ub)
%SET_PARAM_VECTOR Sets parameters to the values specified in the parameter
%vector for SM_background
%   set_param_vector(p) sets p(1) to the first '_val' field
%   
%   Parameters
%   p           Total parameter vector for SM_Background
%

e = obj.enabled;

if numel(lb) ~= numel(ub) || numel(lb) ~= (numel(e(e == true)))
    
    error('Parameter vector does not have the right number of parameters');
    
end % if

ind = 1:numel(e);
obj.params(ind(e == true),1) = num2cell(lb);
obj.params(ind(e == true),3) = num2cell(ub);

end
