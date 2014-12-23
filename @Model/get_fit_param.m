function fp = get_fit_param( obj,tag_or_index )
%GET_FIT_PARAM Returns the fit parameter corresponding to ui element tag or
%index
%   
% fp = get_fit_param(tag_or_index )
%
% Parameters 
%
% tag_or_index      Tag string or linear index of the fit parameter to be
%                   fetched
% 
% Returns
% 
% fp                Fit parameter as double
%

if isfloat(tag_or_index)
    
    index = tag_or_index;
    
elseif ischar(tag_or_index)

    index = obj.param_map(tag_or_index);
    
else
        
    error('Unknown fit_param identifier.');
    
end

fp = obj.fit_param{index};

end

