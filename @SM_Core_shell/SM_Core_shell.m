classdef SM_Core_shell < Scattering_model_spherical & handle
%SM_CORE_SHELL Scattering model for a core-shell a particle
%
%   obj = SM_Core_shell(d)
%
%   Parameters
%   d           Distribution instance
%
%
    
    properties (Constant)
       
        name = 'Core-shell Model';
        
    end
    
    properties (SetAccess = protected)
        
        
        dist;                   % Distribution instance
        
        p_name_strings;         % parameter name strings for gui
        p_ids;                  % internal names for the parameters
        
        params;
        param_map;


    end
    
    methods (Static)
       
        p = p_hard_sphere(qr);
        
    end
    
    
    methods (Access = public)
       
        function obj = SM_Core_shell(d)
            
            
            obj.dist = d;
            
            obj.p_name_strings = {'Amplitude (1/cm)'};
            obj.p_ids = {'a'};
            
            % Model parameters map
            keyset = obj.param_ids_to_tags(obj.p_ids,'params');
            valueset = num2cell(1:numel(keyset));
            
            obj.param_map = containers.Map(keyset(:),valueset);
            
            % Model parameter default values
            obj.params = {0 1 1 1};               % Amplitude
            
        end % constructor  
        
        i_mod = scattered_intensity(obj,nc,q,p);
        [rprf,prf] = radial_profile(obj);
        lims = axis_lims(obj);
        
    end % public methods
    
end

