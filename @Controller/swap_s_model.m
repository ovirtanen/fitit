function swap_s_model(obj,sm)
%SWAP_S_MODEL Swaps the Scattering_model instance in Model
%
%   swap_s_model(sm)
%
%   Parameters
%   sm          A Scattering_model instance
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

if not(isa(sm,'Scattering_model'))
    
    error('Parameter is not a Scattering_model instance.');
    
end

obj.model.replace_s_model(sm); % includes model.update_handles()

obj.view.swap_panel('sm_panel');
obj.sm_ui_cleanup(sm.name);

end

