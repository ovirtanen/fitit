classdef SM_Background < Scattering_model & handle
%SM_SOLVENT Scattering model for solvent background scattering
%
%   obj = SM_Background()
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.
    
properties (Constant)
            
    name = 'Background scattering';
            
end
    
    
properties (SetAccess = protected)
              
    dist;                   % Distribution instance
        
    p_name_strings;         % parameter name strings for gui
    p_ids;                  % internal names for the parameters
        
    params;
    param_map;

    enabled;                % background enabled

end
    

methods (Access = public)
        
    function obj = SM_Background()
               
        obj.dist = [];
            
        obj.p_name_strings = {'Background (cm^{-1})'};
        obj.p_ids = {'bg'};
            
        % Model parameters map
        keyset = obj.param_ids_to_tags(obj.p_ids,'params');
        valueset = num2cell(1:numel(keyset));
            
        obj.param_map = containers.Map(keyset(:),valueset);
            
        % Model parameter default values
        obj.params = {1e-6 1e-5 1e-4 1};               % BG
        
        obj.enabled = 0;
            
    end % constructor
        
    function i_mod = scattered_intensity(obj)
        
        if obj.enabled
            
            i_mod = obj.params{2};
            
        else
           
            i_mod = 0;
            
        end
            
    end
    
    function toggle_bg(obj,toggle)
       
        switch toggle
            
            case 'on'
                
                obj.enabled = 1;
                
            case 'off'
                
                obj.enabled = 0;
                
            otherwise
                
                error('Invalid toggle value.');
                
        end % switch
        
    end
           
        
end % public methods
    
    
end

