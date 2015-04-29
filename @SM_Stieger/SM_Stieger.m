classdef SM_Stieger < Scattering_model_spherical & handle
    %SM_STIEGER Scattering model for Stieger microgel
    %   Detailed explanation goes here
    
    % Copyright (c) 2015, Otto Virtanen
	% All rights reserved.
    
    properties (Constant)
       
        name = 'Stieger Microgel Model';
        
    end
    
    properties (SetAccess = protected)
        
        
        dist;                   % Distribution instance
        
        p_name_strings;         % parameter name strings for gui
        p_ids;                  % internal names for the parameters
        
        params;
        param_map;


    end
    
    methods (Static)
       
        p = p_mg_stieger(qr,q,f);
        
    end
    
    
    methods (Access = public)
       
        function obj = SM_Stieger(d)
            
            
            obj.dist = d;
            
            obj.p_name_strings = {'Amplitude';
                                  'Fuzziness (nm)'};
            obj.p_ids = {'a';
                         'fuzz'};
            
            % Model parameters map
            keyset = obj.param_ids_to_tags(obj.p_ids,'params');
            valueset = num2cell(1:numel(keyset));
            
            obj.param_map = containers.Map(keyset(:),valueset);
            
            % Model parameter default values
            obj.params = {0 1 1 1;
                          1 20 100 1};               % Amplitude
            
        end % constructor  
        
        i_mod = scattered_intensity(obj,nc,q,p);
        [rprf,prf] = radial_profile(obj);
        lims = axis_lims(obj);
        
    end % public methods
    
end

