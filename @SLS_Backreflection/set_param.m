function set_param(obj,tag,param)
%SET_PARAM Set a parameter in SLS_backrelfection

Lib.inargtchck(param,@(x) all([isfloat(x) x >= 0]));

if strcmp(tag,'wl_val')
    
    obj.w_length = param;
    
elseif strcmp(tag,'ri_val')
    
    obj.refr_index = param;
    
elseif strcmp(tag,'eta_min')
    
    obj.eta{1} = param;
    
elseif strcmp(tag,'eta_val')
    
    obj.eta{2} = param;
    
elseif strcmp(tag,'eta_max')
    
    obj.eta{3} = param;
    
elseif strcmp(tag,'eta_chck')
    
    obj.eta{4} = param;
    
else
    
    error('Tag not recognized.');
    
end

end

