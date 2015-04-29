function si_scale_callback(obj,hObject,callbackdata)
%SI_SCALE_CALLBACK Callback for changing the scale of si axis

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

si = findobj(obj.view.gui,'Tag','si_axes');

switch hObject.Tag
   
    case 'loglin_scale'
        
        si.XScale = 'linear';
        si.YScale = 'log';
        
    case 'loglog_scale'
        
        si.XScale = 'log';
        si.YScale = 'log';
        
    otherwise
        
        error('Scale type not recognized.');
    
    
end % switch

end

