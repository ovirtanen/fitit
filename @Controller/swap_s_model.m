function swap_s_model(obj,sm)
%SWAP_S_MODEL Swaps the Scattering_model instance in Model
%
%   swap_s_model(sm)
%
%   Parameters
%   sm          A Scattering_model instance
%


if not(isa(sm,'Scattering_model'))
    
    error('Parameter is not a Scattering_model instance.');
    
end

obj.model.replace_s_model(sm);

obj.view.swap_panel('sm_panel');

end

