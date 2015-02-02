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
        
    case 'Stieger Microgel Model'
        
        sm = SM_Stieger(d);
        obj.swap_s_model(sm);
        
    case 'Virtanen Microgel Model'
        
        sm = SM_Virtanen(d);
        obj.swap_s_model(sm);
        

    otherwise
        
        error('Distribution label not recognized.');
    
end % switch

end

