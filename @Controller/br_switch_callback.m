function br_switch_callback(obj,hObject,callbackdata)
%BR_SWITCH_CALLBACK Callback for toggling SLS back reflection

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.


switch isempty(obj.model.sls_br)
    
    case true
        
        for i = 1:max(1,numel(obj.model.data_sets))
        
            obj.model.initialize_sls_backreflection(1.332,658,0.003,1);
 
        end

        obj.view.initialize_br_panel(obj.view.gui);
        
        obj.view.update_axes();

        hObject.Label = 'Disable SLS Backreflection';
        
    case false
        
        obj.model.remove_sls_backreflection();
        obj.view.delete_br_panel();
        
        obj.model.update_handles();
        obj.view.update_axes();
        
        hObject.Label = 'Enable SLS Backreflection';
end



end