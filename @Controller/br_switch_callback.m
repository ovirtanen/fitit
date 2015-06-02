function br_switch_callback(obj,hObject,callbackdata)
%BR_SWITCH_CALLBACK Callback for toggling SLS back reflection

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

sbr = obj.model.sls_br;

if not(isempty(sbr))

    [enable,ri,wl,eta,fixed] = obj.view.display_br_dialog(sbr.refr_index,sbr.w_length,sbr.eta{2},sbr.eta{4});

else
    
    [enable,ri,wl,eta,fixed] = obj.view.display_br_dialog(1.332,658,0.003,1);
    
end

if isempty([enable ri wl eta fixed])
    return; % box was cancelled
end

Lib.inargtchck(enable, @islogical,...
               ri, @isfloat,...
               wl, @isfloat,...
               eta, @isfloat,...
               fixed, @islogical);

if enable % initializes and replaces if update
    
    obj.model.initialize_sls_backreflection(ri,wl,eta,fixed);
    
else
    
    sbr.disable();
    obj.model.update_handles();
    
end
           
obj.view.update_axes();

end