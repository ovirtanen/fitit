classdef SM_Hard_sphere < Scattering_model_spherical & handle
%SM_HARD_SPHERE Scattering model for hard spheres
%
%   obj = SM_Hard_sphere(d)
%
%   Parameters
%   d           Distribution instance
%
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.
    
    properties (Constant)
       
        name = 'Hard Sphere Model';
        
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
       
        function obj = SM_Hard_sphere(d)
            
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

