function [i_mod] = total_scattered_intensity(obj,nc,q,varargin)
%TOTAL_SCATTERED_INTENSITY Total scattered intensity of all
%Scattering_models and background for one dataset
%   
%   i_mod = total_scattered_intensity(nc,q)
%   i_mod = total_scattered_intensity(nc,q,q_refl,eta)
%
%   Parameters
%   nc          number of collocation points for the PSD
%   q           scattering vector magnitudes
%   q_refl      scattering vector magnitudes of the back reflection
%   eta         weight of the back reflection
%   
%   Returns
%   i_mod       Total scattering intensity
%
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

i_mod = zeros(numel(q),1);


switch isempty(varargin) % avoid checking varargin on every iteration
   
 
    case 1 % --------------------------------------------------------------
        
        for i = 1:numel(obj.s_models)
   
            sm = obj.s_models{i};
            p = obj.get_total_s_model_param_vector(sm);

            i_mod = i_mod + sm.scattered_intensity(nc,q,p);
        
        end % for
        
        i_mod = i_mod + obj.bg.scattered_intensity();
        
    case 0 % --------------------------------------------------------------

        for i = 1:numel(obj.s_models)
   
            sm = obj.s_models{i};
            p = obj.get_total_s_model_param_vector(sm);
    
            q_refl = varargin{1};
            eta = varargin{2};
            
            i_mod = i_mod + sm.scattered_intensity(nc,q,p) + eta .* sm.scattered_intensity(nc,q_refl,p);
            
        end % for
        
        i_mod = i_mod + (1+eta) .* obj.bg.scattered_intensity();
    
end % switch



end