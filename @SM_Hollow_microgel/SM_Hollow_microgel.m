classdef SM_Hollow_microgel < Scattering_model_spherical & handle
%SM_HARD_SPHERE Scattering model for hollowish microgels with exponentially
%decaying denisty profile
%
%   obj = Hollow_microgel(d)
%
%   Parameters
%   d           Distribution instance
%
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.
    
    properties (Constant)
       
        name = 'Hollow microgel model';
        
    end
    
    properties (SetAccess = protected)
        
        dist;                   % Distribution instance
        
        p_name_strings;         % parameter name strings for gui
        p_ids;                  % internal names for the parameters
        
        params;
        param_map;


    end
    
    methods (Static)
       
        v = V(r,dr);
        bq = f_hmg(q,r,dr);
        
    end
    
    methods (Access = public)
       
        function obj = SM_Hollow_microgel(d)
            
            obj.dist = d;
            
            obj.p_name_strings = {'Amplitude (1/cm)';
                                  'Log10 Decay rate'};
            obj.p_ids = {'a';
                         'dr'};
            
            % Model parameters map
            keyset = obj.param_ids_to_tags(obj.p_ids,'params');
            valueset = num2cell(1:numel(keyset));
            
            obj.param_map = containers.Map(keyset(:),valueset);
            
            % Model parameter default values
            obj.params = {0 1 1 1;
                          -4 -2 -1 1};               % Amplitude
            
        end % constructor  
        
        i_mod = scattered_intensity(obj,nc,q,p);
        [rprf,prf] = radial_profile(obj);
        lims = axis_lims(obj);
        n = n_total_params(obj); 
        
    end % public methods
    
end

