function model_menu_callback(obj,hObject,callbackdata)
%MODEL_MENU_CALLBACK Callback for changing scattering model through menu
%bar model menu
%  

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

% for simplicity, remove all fit related data from nodes in Batch_loader
obj.model.bl.reset_nodes();

asm = obj.model.get_active_s_model();
d = asm.dist;

%% Initialization

% Determine L-Curve in Tools is enabled only for SM_Free_profile
l = findobj(obj.view.menu.tools,'Tag','l_curve');
l.Enable = 'off';

%% Swap scattering model

smh = Scattering_model.available_models(hObject.Label); % function handle to constructor

sm = smh(d);

obj.swap_s_model(sm); % includes sm_ui_cleanup

end

