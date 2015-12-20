classdef SM_CS_dumbbell < Scattering_model_spherical & Parallel_capable & handle
%SM_CS_DUMBBELL Scattering model for core-shelldumbbells formed by random aggregation
%of microgels
%
%   obj = SM_CS_dumbbell(d)
%
%   Parameters
%   d           Distribution instance
%
%
    
% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

    properties (Constant)
       
        name = 'Core-shell dumbbell aggregation model';
        
    end
    
    properties (SetAccess = protected)
        
        dist;                   % Distribution instance
        
        p_name_strings;         % parameter name strings for gui
        p_ids;                  % internal names for the parameters
        
        params;
        param_map;


    end
    
    methods (Static)
       
        [id,mwnd] = i_dumbbell(q,rpsd,psd,w,xc,pds,pdc);
        [id,mwnd] = i_dumbbellGPUh(q,rpsd,psd,w,xc,pds,pdc);
        %v = vol_sphere(r);
        
    end
    
    
    methods (Access = public)
       
        function obj = SM_CS_dumbbell(d,b_gpu,b_par)
            
            obj = obj@Parallel_capable(b_gpu,b_par);
            
            obj.dist = d;
            
            obj.p_name_strings = {'Amplitude (1/cm)';...
                                  'Fraction singlets (%)';...
                                  'Frctnl radius of core (%)';...
                                  'PD core';...
                                  'PD shell'};
            obj.p_ids = {'a';...
                         'frs';...
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

