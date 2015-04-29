function par_switch_callback(obj,hObject,Callbackdata)
%PAR_SWITCH_CALLBACK Callback for switching multiple worker capability on 
%or off globally
% 
%   par_switch_callback(hObject,Callbackdata)
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.


sms = obj.model.s_models;

switch obj.par_enabled_global
    
    case 1
        
        obj.par_enabled_global = 0;
        
        for i = 1:numel(sms)
           
            if isa(sms(i),'Parallel_capable')
               
                sms(i).disable_par();
                
            end % if
            
        end % for
        
        p = gcp('nocreate');
        
        if not(isempty(p))
           
            p.delete;
            
        end
        
        hObject.Label = 'Enable Multiple Workers';
        
    case 0
        
        obj.par_enabled_global = 1;
        
        h = waitbar(0,'Starting Parallel Pool...');
        gcp();
        waitbar(1,h);
        close(h)
        
        for i = 1:numel(sms)
           
            if isa(sms(i),'Parallel_capable')
               
                sms(i).enable_par();
                
            end % if
            
        end % for
        
        hObject.Label = 'Disable Multiple Workers';        
        
    otherwise
   
        error('Invalid GPU enabled state.');
    
end % switch

end

