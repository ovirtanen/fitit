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

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

if not(isa(dist,'Distribution'))
    
    error('Parameter is not a Distribution instance.');
    
end

sm = obj.model.get_active_s_model();

sm.set_distribution(dist);

obj.view.swap_panel('dist_panel');

end

