classdef SM_Background < Scattering_model & handle
%SM_SOLVENT Scattering model for solvent background scattering
%
%   obj = SM_Background()
%
    
properties (Constant)
            
    name = 'Background scattering';
            
end
    
    
properties (SetAccess = protected)
              
    dist;                   % Distribution instance
        
    p_name_strings;         % parameter name strings for gui
    p_ids;                  % internal names for the parameters
        
    params;
    param_map;


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
            
    end % constructor
        
    function i_mod = scattered_intensity(obj)
        
        i_mod = obj.params{2};
            
    end
           
        
end % public methods
    
    
end

