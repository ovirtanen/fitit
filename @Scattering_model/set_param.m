function set_param(obj,tag,value)
%GET_PARAM Sets a specific Scattering_model parameter
%
%   set_param(tag,value)
%
%   Parameters
%   tag             Ui element tag string
%   value           Value of the parameter to be set
%

        
index = obj.param_map(tag);
obj.params{index}  = value;


end
