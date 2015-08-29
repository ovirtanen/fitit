classdef Scattering_model < handle
    %SCATTERING_MODEL Abstract class for defining the interface for
    %scattering models
    
    properties (Constant)
       
        available_models = {'Hard Sphere Model';
                            'Hollow Microgel Model';
                            'Core Shell Model';
                            'Free Profile Model, TV reg.';
                            'Free Profile Model, 1st deriv. SN';
                            'Free Profile Model, 2nd deriv. SN';
                            %'Free Profile Model, 2nd deriv. SN';
                            'Core-shell dumbbell aggregation model';
                            'Core-shell triplet aggregation model';
                            'Stieger Microgel Model';
                            'Numerical Microgel Model';
                            'Numerical Microgel Model II';
                            'Numerical Microgel Model III';
                            'Numerical Microgel Model IV';
                            };
        
    end
    
    properties (SetAccess = protected)
       
        scale_param_rows;
        
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
       %x = rm_nan(x,f);
        
   end
    
    methods (Access = public)
        
        function obj = Scattering_model(varargin)
           
             obj.scale_param_rows = 1;   % default value
             
        end
       
        p = get_param(obj,tag);
        p = get_param_vector(obj);
        match_scale_factors_to_ds(obj,nds);
        set_fixed_vector(obj,pf);
        set_param(obj,tag,value);
        set_param_vector(obj,p);
        set_distribution(obj,dist);        
        
    end
    
end

