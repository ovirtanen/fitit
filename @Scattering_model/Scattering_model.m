classdef Scattering_model < handle
    %SCATTERING_MODEL Abstract class for defining the interface for
    %scattering models
    
    properties (Constant)
       
        available_models = {'Hard Sphere Model';
                            'Stieger Microgel Model';
                            'Virtanen Microgel Model';
                            'Virtanen Microgel Model II';
                            'Virtanen Microgel Model III'};
        
    end
    
    properties (Abstract, Constant)
        
        name;
        
    end
    
    properties (Abstract, SetAccess = protected)
   
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
        set_param_vector(obj,p);
        set_distribution(obj,dist);        
        
    end
    
end

