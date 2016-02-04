function set_total_bounds(obj,lb,ub)
%SET_TOTAL_BOUNDS Sets all Scattering_model and Distribution
%upper and lower bounds in the Model
%   
%   set_total_bounds(lb,ub)
%
% Parameters
% lb        Total lower bounds vector
% ub        Total upper bounds vector
%
%

% Copyright (c) 2015,2016 Otto Virtanen
% All rights reserved.

pnd = Pinds(obj);

% Some inelegant counters for tracking the local indices in the Model
% instance.

bri = 0;
smi = 0;

for i = 1:pnd.n_species
    
    [pinds,type] = pnd.next();
    
    switch type
       
        case 'SM_Background'
        
            obj.bg.set_bounds_vectors(lb(pinds),ub(pinds));
            
        case 'SLS_Backreflection'
            
            bri = bri + 1; 
            obj.sls_br(bri).set_bounds_vectors(lb(pinds),ub(pinds));
            
        case 'Scattering_model'
            
            smi = smi + 1;
            obj.s_models{smi}.set_bounds_vectors(lb(pinds),ub(pinds));
            
        otherwise
            
            error('Unrecognized Model component.');
            
    end % switch
    
end

end

