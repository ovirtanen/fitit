function minimize_panel_callback(obj,hObject,callbackdata)
%MINIMIZE_PANEL_CALLBACK Callback for minimizing parameter panels

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

%% Panel sanity check
% Check that user has clicked panel two times within the set interval
% before minimizing the panel

try 
    
    start(obj.view.minimize_timer);
    
catch ME
    
   if not(strcmp(ME.identifier,'MATLAB:timer:alreadystarted'))
      
       rethrow(ME);
       
   end
   
end

obj.view.increment_minimize_counter();

if not(obj.view.minimize_counter == 2)
    
    return;
    
end

%% Minimization

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

