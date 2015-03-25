classdef SM_MG_dumbbell < Scattering_model_spherical & handle
%SM_CORE_SHELL Scattering model for dumbbells formed by random aggregation
%of microgels
%
%   obj = SM_Core_shell(d)
%
%   Parameters
%   d           Distribution instance
%
%
    
    properties (Constant)
       
        name = 'Microgel dumbbell aggregation model';
        
    end
    
    properties (SetAccess = protected)
        
        
        dist;                   % Distribution instance
        
        p_name_strings;         % parameter name strings for gui
        p_ids;                  % internal names for the parameters
        
        params;
        param_map;


    end
    
    methods (Static)
       
        p = i_dumbbell(q,rpsd,psd,w,xc,pds,pdc);
        p = i_dumbbellGPU(q,rpsd,psd,w,xc,pds,pdc);
        p = i_dumbbellGPUh(q,rpsd,psd,w,xc,pds,pdc);
        p = p4(q,xc,r1,r2,pds,pdc);
        v = vol_sphere(r);
        
    end
    
    
    methods (Access = public)
       
        function obj = SM_MG_dumbbell(d)
            
            
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
        
    end % public methods
    
end

