function minimize_panel_callback(obj,hObject,callbackdata)
%MINIMIZE_PANEL_CALLBACK Callback for minimizing parameter panels

s = obj.view.spacers;

if hObject.Position(4) == s.min_p_panel_height
    
    switch hObject.Tag
       
        case 'bg_panel'
            
            nelem = numel(obj.model.bg.p_ids);
            p_height = s.p_title_spacer + (nelem + 1) * s.p_element_height + (nelem + 2) * s.p_v_spacer;
            hObject.Position(4) = p_height;
            
        case 'br_panel'
            
            nelem = numel(obj.model.sls_br);
            p_height = s.p_title_spacer + nelem .* (2.5 .* s.p_element_height +  2.* s.p_v_spacer);
            hObject.Position(4) = p_height;
            
        case 'sm_panel'
            
            nelem = numel(obj.model.s_models{1}.p_name_strings);
            p_height = s.p_title_spacer + (nelem + 1) * s.p_element_height + (nelem + 2) * s.p_v_spacer;
            hObject.Position(4) = p_height;
            
        case 'dist_panel'
            
            nelem = numel(obj.model.s_models{1}.dist.p_name_strings);
            p_height = s.p_title_spacer + (nelem + 1) * s.p_element_height + (nelem + 2) * s.p_v_spacer;
            hObject.Position(4) = p_height;
            
        otherwise
            
            error('Panel type not recognized.');
        
        
    end
    
    
    obj.view.realign_all_controls();
    
else
    
    hObject.Position(4) = s.min_p_panel_height;
    obj.view.realign_all_controls();
    
end


end

