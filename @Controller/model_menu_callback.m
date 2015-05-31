function model_menu_callback(obj,hObject,callbackdata)
%MODEL_MENU_CALLBACK Callback for changing scattering model through menu
%bar model menu
%  

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

asm = obj.model.get_active_s_model();
d = asm.dist;

switch hObject.Label
    
    case 'Hard Sphere Model'
        
        sm = SM_Hard_sphere(d);
        obj.swap_s_model(sm);
        
    case 'Hollow Microgel Model'
        
        sm = SM_Hollow_microgel(d);
        obj.swap_s_model(sm);
        
    case 'Core Shell Model'
        
        sm = SM_Core_shell(d);
        obj.swap_s_model(sm);
        
    case 'Free Profile Model'
        
        sm = SM_Free_profile(d,5);
        obj.swap_s_model(sm);
        
    case 'Microgel dumbbell aggregation model'
        
        sm = SM_MG_dumbbell(d,obj.gpu_enabled_global,obj.par_enabled_global);
        obj.swap_s_model(sm);
        
    case 'Microgel triplet aggregation model'
        
        sm = SM_MG_triplets(d,obj.gpu_enabled_global,obj.par_enabled_global);
        obj.swap_s_model(sm);
        
    case 'Stieger Microgel Model'
        
        sm = SM_Stieger(d);
        obj.swap_s_model(sm);
        
    case 'Numerical Microgel Model'
        
        sm = SM_MG_numerical(d);
        obj.swap_s_model(sm);
        
    case 'Numerical Microgel Model II'
        
        sm = SM_MG_numerical_II(d);
        obj.swap_s_model(sm);
        
    case 'Numerical Microgel Model III'

        sm = SM_MG_numerical_III(d);
        obj.swap_s_model(sm);
        
    case 'Numerical Microgel Model IV'
         
        sm = SM_MG_numerical_IV(d);
        obj.swap_s_model(sm);
            
        
    otherwise
        
        error('Model label not recognized.');
    
end % switch

end

