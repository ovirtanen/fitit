function model_menu_callback(obj,hObject,callbackdata)
%MODEL_MENU_CALLBACK Callback for changing scattering model through menu
%bar model menu
%  

asm = obj.model.get_active_s_model();
d = asm.dist;

switch hObject.Label
    
    case 'Hard Sphere Model'
        
        sm = SM_Hard_sphere(d);
        obj.swap_s_model(sm);
        
    case 'Core Shell Model'
        
        sm = SM_Core_shell(d);
        obj.swap_s_model(sm);
        
    case 'Microgel dumbbell aggregation model'
        
        sm = SM_MG_dumbbell(d);
        obj.swap_s_model(sm);
        
    case 'Microgel triplet model'
        
        sm = SM_MG_triplets(d);
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
        
        error('Distribution label not recognized.');
    
end % switch

end

