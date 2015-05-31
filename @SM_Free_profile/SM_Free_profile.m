classdef SM_Free_profile < Scattering_model_spherical & handle
%SM_FREE_PROFILE Scattering model for a particle with a density profile
%consisting of freely adjustable steps. The model has been implemented as
%spherical cocentric shells model.
%
%   obj = SM_Free_profile(d,n)
%
%   Parameters
%   d           Distribution instance
%   n           Number of steps in the profile
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.
    
    properties (Constant)
       
        name = 'Free Profile Model';
        
    end
    
    properties (SetAccess = protected)
        
        dist;                   % Distribution instance
        n;                      % Number of steps in the profile
        
        p_name_strings;         % parameter name strings for gui
        p_ids;                  % internal names for the parameters
        
        params;
        param_map;


    end
    
    methods (Static)
       
        f = f_hard_sphere(qr);
        A = mult3(A,x);
        
    end
    
    
    methods (Access = public)
       
        function obj = SM_Free_profile(d,n)
            
            obj.dist = d;
            obj.n = n;
            
            % Parameter name strings
            steps = repmat({'Step '},n,1);
            inds  = num2cell(num2str((1:n)'));
            
            obj.p_name_strings = {'Amplitude (1/cm)'}; 
            obj.p_name_strings = [obj.p_name_strings; strcat(steps,inds)];
            
            % Parameter ids
            ids = repmat({'stp'},n,1);
            
            obj.p_ids = {'a'};
            obj.p_ids = [obj.p_ids; strcat(ids,inds)];
            
            % Model parameters map
            keyset = obj.param_ids_to_tags(obj.p_ids,'params');
            valueset = num2cell(1:numel(keyset));
            
            obj.param_map = containers.Map(keyset(:),valueset);
            
            % Model parameter default values
            obj.params = {0 1 1 1};                 % Amplitude
            obj.params = repmat(obj.params,n+1,1);  % Steps: Default values [0 ... 1]
            
        end % constructor  
        
        i_mod = scattered_intensity(obj,nc,q,p);
        [rprf,prf] = radial_profile(obj);
        lims = axis_lims(obj);
        
    end % public methods
    
end
