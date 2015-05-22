classdef SLS_Backreflection <  handle
    %SLS_BACKREFLECTION Class for storing parameters for cuvette back
    %reflection in SLS
    %   
    %   obj = SLS_Backreflection(ri,wl,eta)
    %
    % Parameters
    % ri            Refractive index of the medium
    % wl            Wave length of the laser
    % eta           Fraction of the back reflected light
    
    % Copyright (c) 2015, Otto Virtanen
    % All rights reserved.
    
    properties (SetAccess = private)
        
        refr_index;             % Refractive index of the scattering medium
        w_length;               % Wave length of the laser
        eta;
        
        enabled;                % Back reflection enabled
        
    end
    
         
    methods (Access = public)
        
        function obj = SLS_Backreflection(ri,wl)
            
        obj.refr_index = ri;
        obj.w_length = wl;
        obj.eta = {1e-3 6e-3 3e-2 1};

        obj.enabled = 0;
                   
        end % constructor
        
        qbr = q_brefl(obj,q);
        
        function enable(obj)
           
            obj.enabled = 1;
            
        end
        
        function disable(obj)
            
            obj.enabled = 0;
            
        end
        
        function set_param_vector(obj,p)
           
            obj.eta{2} = p;
            
        end
        
    end % public methods
    
end

