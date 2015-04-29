function gpu_switch_callback(obj,hObject,Callbackdata)
%GPU_SWITCH_CALLBACK Callback for switching GPU capability on or off
%globally
% 
%   gpu_switch_callback(hObject,Callbackdata)
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

sms = obj.model.s_models;

switch obj.gpu_enabled_global
    
    case 1
        
        obj.gpu_enabled_global = 0;
        
        for i = 1:numel(sms)
           
            if isa(sms(i),'Parallel_capable')
               
                sms(i).disable_gpu();
                
            end % if
            
        end % for
        
        obj.gpu.reset();
        hObject.Label = 'Enable GPU';
        
    case 0
        
        obj.gpu_enabled_global = 1;
        
        for i = 1:numel(sms)
           
            if isa(sms(i),'Parallel_capable')
               
                sms(i).enable_gpu();
                
            end % if
            
        end % for
        
        hObject.Label = 'Disable GPU';        
        
    otherwise
   
        error('Invalid GPU enabled state.');
    
end % switch


end

