classdef SM_MG_numerical_II < Scattering_model_spherical & handle
    %SM_VIRTANEN Summary of this class goes here
    %   Detailed explanation goes here
   
    
    properties (Constant)
       
        name = 'Numerical Microgel Model II';
        
    end
    
    properties (SetAccess = protected)
        
        
        dist;                   % Distribution instance
        
        p_name_strings;         % parameter name strings for gui
        p_ids;                  % internal names for the parameters
        
        params;
        param_map;


    end
    
    methods(Static)
       
        
        [rprf, prf] = pd_profile(nc,rhard,sd,cpd,mxspd,fuzz)
        p = vnumP(rc,w,pd,q);
        hri = trg3(r,rinc,rp,v,vm);
        
    end
    
    
    methods (Access = public)
       
        function obj = SM_MG_numerical_II(d)
            
            
            obj.dist = d;
            
            obj.p_name_strings = {'Amplitude (1/cm)';
                                  'Skin depth (%)'
                                  'Core PD (a.u.)';
                                  'Max skin PD (a.u.)'
                                  'Fuzziness (nm)'};
            obj.p_ids = {'a';
                         'sd';
                         'cpd';
                         'mxspd';
                         'fuzz'};
            
            % Model parameters map
            keyset = obj.param_ids_to_tags(obj.p_ids,'params');
            valueset = num2cell(1:numel(keyset));
            
            obj.param_map = containers.Map(keyset(:),valueset);
            
            % Model parameter default values
            obj.params = {0 1 1 1;          % Amplitude
                          0 0 100 1;        % Skin depth 
                          0 1 1 1;            % Core PD
                          0.01 1 1 1;       % Max skin PD
                          1 20 100 1};      % Fuzziness               
            
        end % constructor  
        
        i_mod = scattered_intensity(obj,nc,q,p);
        [rprf,prf] = radial_profile(obj);
        
        lims = axis_lims(obj);
        
    end % public methods
    
end

