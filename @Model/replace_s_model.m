function replace_s_model(obj,sm)
%REPLACE_S_MODEL Replaces the currently active Scattering_model
%
%   replace_s_model(sm)
%
%   Parameters
%   sm      Scattering_model instance that deletes and replaces the
%           currently active Scattering_model

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

obj.update_handles();

end

