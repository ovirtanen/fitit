classdef SM_SANS_HS < Scattering_model_spherical & handle
%SM_SANS_HS Hard sphere model with polymer network fluctuation term
%
%   obj = SM_SANS_HS(d)
%
%   Parameters
%   d           Distribution instance
%
%

% Copyright (c) 2016, Otto Virtanen
% All rights reserved.
    
    properties (Constant)
       
        name = 'SANS Polymer Particle Model';
        
    end
    
    properties (SetAccess = protected)
        
        dist;                   % Distribution instance
        
        p_name_strings;         % parameter name strings for gui
        p_ids;                  % internal names for the parameters
        
        params;
        param_map;


    end
    
    methods (Static)
       
        f = f_hard_sphere(qr);
        
    end
    
    
    methods (Access = public)
       
        function obj = SM_SANS_HS(d)
            
            obj.dist = d;
            
            obj.p_name_strings = {'Amplitude (1/cm)';...
                                  'Fluct. Ampl. (1/cm)';...
                                  'Zeta'};
            obj.p_ids = {'a';...
                         'fa';...
                         'zeta'};
            
            % Model parameters map
            keyset = obj.param_ids_to_tags(obj.p_ids,'params');
            valueset = num2cell(1:numel(keyset));
            
            obj.param_map = containers.Map(keyset(:),valueset);
            
            % Model parameter default values
            obj.params = {0.1 1e3 3e4 1;...               % Amplitude
                          0.1 1 1e3 1;...               % Polymer fluctuation amplitude
                          0.1 1 100 1};               % Network correlation length
            
        end % constructor  
        
        i_mod = scattered_intensity(obj,nc,q,p);
        [rprf,prf] = radial_profile(obj);
        lims = axis_lims(obj);
        n = n_total_params(obj);
        
        
    end % public methods
    
end

