function replace_s_model(obj,sm)
%REPLACE_S_MODEL Replaces the currently active Scattering_model
%
%   replace_s_model(sm)
%
%   Parameters
%   sm      Scattering_model instance that deletes and replaces the
%           currently active Scattering_model


switch numel(obj.s_models)
   
    case 0
        
        error('Model uninitialized');
    
    case 1
        
        obj.active_s_model = 1;
        obj.s_models = sm;
        
    otherwise
        
        obj.s_models(obj.active_s_model) = sm;
    
end


end

