classdef SM_Core_shell < Scattering_model_spherical & handle
%SM_CORE_SHELL Scattering model for a core-shell a particle
%
%   obj = SM_Core_shell(d)
%
%   Parameters
%   d           Distribution instance
%
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.
    
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
       
        f = f3(q,rp,rc,pds,pdc);
        m = m3(rp,rc,pds,pdc);
        v = vol_sphere(r);
        
    end
    
    
    methods (Access = public)
       
        function obj = SM_Core_shell(d)
            
            
            obj.dist = d;
            
            obj.p_name_strings = {'Amplitude (1/cm)';...
                                  'Frctnl radius of core (%)';...
                                  'PD core';...
                                  'PD shell'};
            obj.p_ids = {'a';
                         'frc';...
                         'pdc';...
                         'pds'};
            
            % Model parameters map
            keyset = obj.param_ids_to_tags(obj.p_ids,'params');
            valueset = num2cell(1:numel(keyset));
            
            obj.param_map = containers.Map(keyset(:),valueset);
            
            % Model parameter default values
            obj.params = {0 1 1 1;
                          0 50 100 1;
                          -1 1 1 1;
                          -1 1 1 1};               
            
        end % constructor  
        
        i_mod = scattered_intensity(obj,nc,q,p);
        [rprf,prf] = radial_profile(obj);
        lims = axis_lims(obj);
        n = n_total_params(obj);  
        
    end % public methods
    
end

