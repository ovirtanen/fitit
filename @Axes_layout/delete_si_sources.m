function delete_si_sources(obj)
%DELETE_SI_SOURCES Deletes all the Graphics_source instances that have
%si_axes as target axis
%
%   delete_si_sources()

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

switch numel(obj.g_sources)
   
    case 0
        
        % do nothing
    
    case 1
        
        if strcmp(obj.g_sources.target_axis.Tag,'si_axes')
           
            obj.g_sources = [];
            
        end % if
        
    otherwise 
    
        f = [];
        for i = 1 : numel(obj.g_sources)
            
            gs = obj.g_sources(i);
            
            if strcmp(gs.target_axis.Tag,'si_axes')
           
                f = [f i];
                
            end % if
            
        end % for
        
        delete(obj.g_sources(f));
        obj.g_sources(f) = [];
        
end % switch


end

