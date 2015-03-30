classdef SM_MG_numerical_III < Scattering_model_spherical & handle
    %SM_VIRTANEN Summary of this class goes here
    %   Detailed explanation goes here
   
    
    properties (Constant)
       
        name = 'Numerical Microgel Model III';
        
    end
    
    properties (SetAccess = protected)
        
        
        dist;                   % Distribution instance
        
        p_name_strings;         % parameter name strings for gui
        p_ids;                  % internal names for the parameters
        
        params;
        param_map;


    end
    
    methods(Static)
       
        
        [rprf, prf] = pd_profile(nc,rhard,sthck,tau,vskin,fuzz)
        p = vnumP(rc,w,pd,q);
        hri = trg5(r,tau,rp,sthck,vm);
        
    end
    
    
    methods (Access = public)
       
        function obj = SM_MG_numerical_III(d)
            
            
            obj.dist = d;
            
            obj.p_name_strings = {'Amplitude (1/cm)';
                                  'Shell thickness (nm)'
                                  'Max decay rate';
                                  'Max skin PD'
                                  'Fuzziness (nm)'};
            obj.p_ids = {'a';
                         'sth';
                         'dr';
                         'mxspd'
                         'fuzz'};
            
            % Model parameters map
            keyset = obj.param_ids_to_tags(obj.p_ids,'params');
            valueset = num2cell(1:numel(keyset));
            
            obj.param_map = containers.Map(keyset(:),valueset);
            
            % Model parameter default values
            obj.params = {0 1 1 1;          % Amplitude
                          0 10 100 1;       % Shell thickness
                          1e-5 1e-5 1e-2 1; % Decay rate
                          0.01 1 1 1;       % Max skin PD
                          1 20 100 1};      % Fuzziness               
            
        end % constructor  
        
        i_mod = scattered_intensity(obj,nc,q,p);
        [rprf,prf] = radial_profile(obj);
        
        lims = axis_lims(obj);
        
    end % public methods
    
end

