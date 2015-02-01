classdef Scattering_model < handle
    %SCATTERING_MODEL Abstract class for defining the interface for
    %scattering models
    
    properties (Abstract, SetAccess = protected)
        
        name;
        dist;
        
        p_name_strings;
        p_ids;
        
        params;
        param_map;
        
    end
    
   
    methods (Abstract)
        
        intst = scattered_intensity(obj,nc,q,p);
        
    end
    
    methods (Static)
      
       tags = param_ids_to_tags(param_names, mode);
       x = rm_nan(x,f);
        
   end
    
    methods (Access = public)
       
        p = get_param(obj,tag);
        p = get_param_vector(obj)
        set_param(obj,tag,value);
        
    end
    
end

