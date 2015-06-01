classdef SLS_Backreflection <  handle
    %SLS_BACKREFLECTION Class for storing parameters for cuvette back
    %reflection in SLS
    %   
    %   obj = SLS_Backreflection(ri,wl,eta,fixed)
    %
    % Parameters
    % ri            Refractive index of the medium
    % wl            Wave length of the laser
    % eta           Fraction of the back reflected light
    % fixed         1 if eta is fixed parameter, otherwise 0
    
    % Copyright (c) 2015, Otto Virtanen
    % All rights reserved.
    
    properties (SetAccess = private)
        
        refr_index;             % Refractive index of the scattering medium
        w_length;               % Wave length of the laser
        eta;
        
        enabled;                % Back reflection enabled
        
    end
    
         
    methods (Access = public)
        
        function obj = SLS_Backreflection(ri,wl,eta,fixed)
            
        obj.refr_index = ri;
        obj.w_length = wl;
        obj.eta = {0 eta 1 fixed};

        obj.enabled = false;
                   
        end % constructor
        
        qbr = q_brefl(obj,q);
        
        function enable(obj)
           
            obj.enabled = true;
            
        end
        
        function disable(obj)
            
            obj.enabled = false;
            
        end
        
        function set_param_vector(obj,p)
           
            obj.eta{2} = p;
            
        end
        
    end % public methods
    
end

