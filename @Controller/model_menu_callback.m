function model_menu_callback(obj,hObject,callbackdata)
%MODEL_MENU_CALLBACK Callback for changing scattering model through menu
%bar model menu
%  

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

asm = obj.model.get_active_s_model();
d = asm.dist;

%% Initialization

% Determine L-Curve in Tools is enabled only for SM_Free_profile
l = findobj(obj.view.menu.tools,'Tag','l_curve');
l.Enable = 'off';

%% Swap scattering model

switch hObject.Label
    
    case 'Hard Sphere Model'
        
        sm = SM_Hard_sphere(d);
        
        
    case 'Hollow Microgel Model'
        
        sm = SM_Hollow_microgel(d);
        
    case 'Core Shell Model'
        
        sm = SM_Core_shell(d);
        
    %case 'Free Profile Model, 2-norm'
        
        %sm = SM_Free_profile(d,20,0);
        
    case 'Free Profile Model, TV reg.'
        
        sm = SM_Free_profile(d,20,-1);
        
    case 'Free Profile Model, 1st deriv. SN'
        
        sm = SM_Free_profile(d,20,0);
        
    case 'Free Profile Model, 2nd deriv. SN'
        
        sm = SM_Free_profile(d,20,1);
        
    case 'Core-shell dumbbell aggregation model'
        
        sm = SM_CS_dumbbell(d,obj.gpu_enabled_global,obj.par_enabled_global);
        
    case 'Core-shell triplet aggregation model'
        
        sm = SM_CS_triplets(d,obj.gpu_enabled_global,obj.par_enabled_global);
        
    case 'Stieger Microgel Model'
        
        sm = SM_Stieger(d);
        
    case 'Numerical Microgel Model'
        
        sm = SM_MG_numerical(d);
        
    case 'Numerical Microgel Model II'
        
        sm = SM_MG_numerical_II(d);
        
    case 'Numerical Microgel Model III'

        sm = SM_MG_numerical_III(d);
        
    case 'Numerical Microgel Model IV'
         
        sm = SM_MG_numerical_IV(d);
        
    otherwise
        
        error('Model label not recognized.');
    
end % switch

sm.match_scale_factors_to_ds(max([1 numel(obj.model.data_sets)]));
obj.swap_s_model(sm); % includes sm_ui_cleanup

end

