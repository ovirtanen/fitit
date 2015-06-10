function dist_menu_callback(obj,hObject,callbackdata)
%DIST_MENU_CALLBACK Callback for changing distribution through Distribution
%menu bar menu
%   

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

switch hObject.Label
    
    case 'Burr Type XII PSD'
        
        d = DST_BurrXII();
        obj.swap_distribution(d);
        
    case 'Gaussian PSD'
        
        d = DST_Gaussian();
        obj.swap_distribution(d);
        
    case 'Gumbel PSD'
        
        d = DST_Gumbel();
        obj.swap_distribution(d);
        
        
    case 'Lognormal PSD'
        
        d = DST_Lognrml();
        obj.swap_distribution(d);
        
    case 'Skew normal PSD'
        
        d = DST_Skewnrml();
        obj.swap_distribution(d);
        
    otherwise
        
        error('Distribution label not recognized.');
    
end % switch


end

