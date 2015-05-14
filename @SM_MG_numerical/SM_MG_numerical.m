classdef SM_MG_numerical < Scattering_model_spherical & handle
    %SM_VIRTANEN Summary of this class goes here
    %   Detailed explanation goes here
   
    % Copyright (c) 2015, Otto Virtanen
    % All rights reserved.
    
    
    properties (Constant)
       
        name = 'Numerical Microgel Model';
        
    end
    
    properties (SetAccess = protected)
        
        
        dist;                   % Distribution instance
        
        p_name_strings;         % parameter name strings for gui
        p_ids;                  % internal names for the parameters
        
        params;
        param_map;


    end
    
    methods(Static)
       
        
        [rprf, prf,w] = pd_profile(nc,rhard,tau,vskin,fuzz);
        p = vnumP(rc,w,pd,q);
        hri = trg4(r,tau,rp,vm);
        
    end
    
    
    methods (Access = public)
       
        function obj = SM_MG_numerical(d)
            
            
            obj.dist = d;
            
            obj.p_name_strings = {'Amplitude (1/cm)';
                                  'Max decay rate';
                                  'Max skin PD'
                                  'Fuzziness (nm)'};
            obj.p_ids = {'a';
                         'dr';
                         'mxspd'
                         'fuzz'};
            
            % Model parameters map
            keyset = obj.param_ids_to_tags(obj.p_ids,'params');
            valueset = num2cell(1:numel(keyset));
            
            obj.param_map = containers.Map(keyset(:),valueset);
            
            % Model parameter default values
            obj.params = {0 1 1 1;          % Amplitude
                          1e-5 1e-5 1e-2 1; % Decay rate
                          0.01 1 1 1;       % Max skin PD
                          1 20 100 1};      % Fuzziness               
            
        end % constructor  
        
        i_mod = scattered_intensity(obj,nc,q,p);
        [rprf,prf] = radial_profile(obj);
        
        lims = axis_lims(obj);
        
    end % public methods
    
end

