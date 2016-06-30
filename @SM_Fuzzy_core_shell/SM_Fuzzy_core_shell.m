classdef SM_Fuzzy_core_shell < Scattering_model_spherical & handle
%SM_CORE_SHELL Scattering model for a fuzzy core-shell a particle
%
%   obj = SM_Fuzzy_core_shell(d)
%
%   Parameters
%   d           Distribution instance
%
% Berndt, I., Pedersen, J. S., Lindner, P., & Richtering, W. (2006). 
% Langmuir, 22(1), 459?468. 
% http://doi.org/10.1021/la052463u

% Copyright (c) Otto Virtanen and Arjan Gelissen 2016
% All rights reserved.
    
    properties (Constant)
       
        name = 'Fuzzy_core_shell Model';
        
    end
    
    properties (SetAccess = protected) % do not edit!
        
        
        dist;                   % Distribution instance
        
        p_name_strings;         % parameter name strings for gui
        p_ids;                  % internal names for the parameters
        
        params;
        param_map;


    end
    
    methods (Static)
       
        r = phi(q,R,sigma);
        
    end
    
    
    methods (Access = public)
       
        function obj = SM_Fuzzy_core_shell(d)
            
            
            obj.dist = d;
            
            obj.p_name_strings = {'Amplitude (1/cm)';
                                  'R hard core (%)';
                                  'Sigma core (%)';
                                  'Hard shell width (%)';
                                  'Core contrast';
                                  'Shell contrast';
                                  };
                          
            obj.p_ids = {'a';
                         'r_box';
                         'sigma_core';
                         'ws';
                         'vfc';
                         'vfs';
                         };
            
            % Model parameters map
            keyset = obj.param_ids_to_tags(obj.p_ids,'params');
            valueset = num2cell(1:numel(keyset));
            
            obj.param_map = containers.Map(keyset(:),valueset);
            
            % Model parameter default values
            obj.params = {0 1 1 1;
                          0 0.5 1 1;
                          0.001 0.05 0.5 1
                          0 0.3 1 1;
                          0 1 1 1;
                          0 1 1 1;
                          };             
            
        end % constructor  
        
        i_mod = scattered_intensity(obj,nc,q,p);
        [rprf,prf] = radial_profile(obj);
        lims = axis_lims(obj);
        n = n_total_params(obj);  
        
    end % public methods
    
end

