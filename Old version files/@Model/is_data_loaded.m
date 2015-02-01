function b = is_data_loaded(obj)
%IS_DATA_LOADED Returns true if empirical data has been loaded, otherwise
%false
%
% b = is_data_loaded()
%

if all([isempty(obj.intensity) isempty(obj.q) isempty(obj.std)])
    
    b = false;
    
elseif any([isempty(obj.intensity) isempty(obj.q) isempty(obj.std)])
    
    error('Error in data loading.');
    
else
    
    b = true;
    
end % if


end

