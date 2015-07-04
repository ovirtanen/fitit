classdef SM_CS_triplets < Scattering_model_spherical & Parallel_capable & handle
%SM_CS_TRIPLETS Scattering model for core-shell triplets
%
%   obj = SM_CS_triplets(d)
%
%   Parameters
%   d           Distribution instance
%
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.
    
    properties (Constant)
       
        name = 'Core-shell triplet aggregation model';
        
    end
    
    properties (SetAccess = protected)
        
        dist;                   % Distribution instance
        
        p_name_strings;         % parameter name strings for gui
        p_ids;                  % internal names for the parameters
        
        params;
        param_map;


    end
    
    methods (Static)
       
        [id,swdbl] = i_dumbbellGPUh(q,rpsd,psd,w,xc,pds,pdc);
        [i_trpl, swtrpl] = i_tripletsGPU(q,rpsd,psd,w,xl,xc,pds,pdc);
        [i_trpl, swtrpl] = i_tripletsPAR(q,rpsd,psd,w,xl,xc,pds,pdc);
        [id,swdbl] = i_dumbbellPAR(q,rpsd,psd,w,xc,pds,pdc)
        p = itrpl(q,r1,r2,r3,xc,xl,pds,pdc,psdw);
        p = pdb(q,r1,r2,xc,pds,pdc,psdwg);
        a = nullify(a);
        p = weight(p,r1,r2,r3,w);
        w = m3(rp,rc,pds,pdc);
        
        
        
    end
    
    
    methods (Access = public)
       
        function obj = SM_CS_triplets(d,b_gpu,b_par)
            
            obj = obj@Parallel_capable(b_gpu,b_par);
            
            obj.dist = d;
            
            obj.p_name_strings = {'Amplitude (1/cm)';...
                                  'Fraction multiplets';...
                                  'Fraction triplets (of mps)'; ...
                                  'Fraction linears (%)';...
                                  'Frctnl radius of core (%)';...
                                  'PD core';...
                                  'PD shell'};
            obj.p_ids = {'a';...
                         'frml';...
                         'frtr';...
                         'frl';...
                         'frc';...
                         'pdc';...
                         'pds'};
            
            % Model parameters map
            keyset = obj.param_ids_to_tags(obj.p_ids,'params');
            valueset = num2cell(1:numel(keyset));
            
            obj.param_map = containers.Map(keyset(:),valueset);
            
            % Model parameter default values
            obj.params = {0 1 1 1;
                          0 0 100 1;
                          0 0 100 1;
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

