function set_total_fixed_vector(obj,f)
%SET_TOTAL_FIXED_VECTOR Sets all Scattering_model, Distribution,
%SM_Background and SLS_Backreflection fixed parameter values in the Model
%   
%   set_total_fixed_vector(f)

% Copyright (c) 2016, Otto Virtanen
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
        
            obj.bg.set_fixed_vector(f(pinds));
            
        case 'SLS_Backreflection'
            
            bri = bri + 1; 
            obj.sls_br(bri).set_fixed_vector(f(pinds));
            
        case 'Scattering_model'
            
            smi = smi + 1;
            obj.s_models{smi}.set_fixed_vector(f(pinds));
            
        otherwise
            
            error('Unrecognized Model component.');
            
    end % switch
    
end


end

