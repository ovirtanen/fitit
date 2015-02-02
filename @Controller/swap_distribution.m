function swap_distribution(obj,dist)
%SWAP_DISTRIBUTION Swaps the distribution instance in active
%Scattering_model
%   
%   swap_distribution(dist)
%
%   Parameters
%   dist            A Distribution instance
%
%

if not(isa(dist,'Distribution'))
    
    error('Parameter is not a Distribution instance.');
    
end

sm = obj.model.get_active_s_model();

sm.set_distribution(dist);

obj.view.swap_panel('dist_panel');

end

