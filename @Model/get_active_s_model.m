function sm = get_active_s_model(obj)
%GET_ACTIVE_S_MODEL Returns a reference to currently active
%Scattering_model instance
%   


sm = obj.s_models(obj.active_s_model);


end

