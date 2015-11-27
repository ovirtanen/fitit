function replace_s_model(obj,sm)
%REPLACE_S_MODEL Replaces the currently active Scattering_model
%
%   replace_s_model(sm)
%
%   Parameters
%   sm      Scattering_model instance that deletes and replaces the
%           currently active Scattering_model
%
% Updates handles, adjusts the number of parameters based on the number of
% datasets.
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

switch numel(obj.s_models)
   
    case 0 % error
        
        error('Model uninitialized');
        
    
    case 1 % background + scattering model
        
        obj.active_s_model = 1;
        obj.s_models{obj.active_s_model} = sm;
        
    otherwise % background and several scattering models
        
        obj.s_models{obj.active_s_model} = sm;
    
end

obj.s_models{obj.active_s_model}.match_scale_factors_to_ds(max([1 numel(obj.data_sets)]));
obj.update_handles();

end

