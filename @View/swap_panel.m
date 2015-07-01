function swap_panel(obj,tag)
%SWAP_PANEL Deletes and reinitializes parameter panel and 
%redraws the GUI
%   
%   swap_p_panel(tag)
%
%   Parameters
%   tag         Tag of the parameter panel to be swapped, 'dist_panel' or
%               'sm_panel'

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

obj.d_panel.Visible = 'off';
obj.f_button.Visible = 'off';

sm = obj.model.get_active_s_model;          % scattering model
dist = sm.dist;                             % distribution

switch tag

    case 'dist_panel'
        
        delete(obj.d_panel);
        obj.d_panel = obj.initialize_param_panel(obj.gui,dist,tag);
        
    case 'sm_panel'
        
        delete(obj.p_panel);
        obj.p_panel = obj.initialize_param_panel(obj.gui,sm,tag);
        
    case 'bg_panel'
        
        delete(obj.bg_panel);
        obj.bg_panel = obj.initialize_bg_panel(obj.gui);
        
    case 'br_panel'
        
        delete(obj.br_panel);
        obj.initialize_br_panel(obj.gui);
        
    otherwise
        
        error('Panel tag not recognized.')
   
end

obj.realign_all_controls();

obj.update_axes();

end



