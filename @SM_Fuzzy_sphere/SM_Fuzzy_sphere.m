classdef SM_Fuzzy_sphere < Scattering_model_spherical & handle
    %SM_STIEGER Scattering model for Stieger microgel
    %   Detailed explanation goes here
    
    % Copyright (c) 2015, Otto Virtanen
	% All rights reserved.
    
    properties (Constant)
       
        name = 'Fuzzy Sphere Model';
        
    end
    
    properties (SetAccess = protected)
        
        
        dist;                   % Distribution instance
        
        p_name_strings;         % parameter name strings for gui
        p_ids;                  % internal names for the parameters
        
        params;
        param_map;


    end
    
    methods (Static)
       
        p = phi(q,r,sigma);
        
    end
    
    
    methods (Access = public)
       
        function obj = SM_Fuzzy_sphere(d)
            
            
            obj.dist = d;
            
            obj.p_name_strings = {'Amplitude (cm-^)';
                                  '2 x sigma (%)'};
            obj.p_ids = {'a';
                         '2sigma'};
            
            % Model parameters map
            keyset = obj.param_ids_to_tags(obj.p_ids,'params');
            valueset = num2cell(1:numel(keyset));
            
            obj.param_map = containers.Map(keyset(:),valueset);
            
            % Model parameter default values
            obj.params = {0 1 1 1;              % Amplitude
                          0.01 0.5 1 1};           % Width ofthe total fuzzy section (2 x sigma) as fraction of total particle radius               
            
        end % constructor  
        
        i_mod = scattered_intensity(obj,nc,q,p);
        [rprf,prf] = radial_profile(obj);
        lims = axis_lims(obj);
        n = n_total_params(obj); 
        
    end % public methods
    
end

