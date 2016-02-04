function set_total_parameter_vector(obj,p)
%SET_TOTAL_PARAMETER_VECTOR Sets all Scattering_model and Distribution
%parameters in the Model
%   
%   set_total_parameter_vector(p)
%
%

% Copyright (c) 2015, Otto Virtanen
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
        
            obj.bg.set_param_vector(p(pinds));
            
        case 'SLS_Backreflection'
            
            bri = bri + 1; 
            obj.sls_br(bri).set_param_vector(p(pinds));
            
        case 'Scattering_model'
            
            smi = smi + 1;
            obj.s_models{smi}.set_param_vector(p(pinds));
            
        otherwise
            
            error('Unrecognized Model component.');
            
    end % switch
    
end

end

