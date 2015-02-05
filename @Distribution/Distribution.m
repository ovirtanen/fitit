classdef Distribution < handle
    %DISTRIBUTION Class defining the interface for particle size
    %distributions
    %
    %   Abstract properties, protected
    %
    %    name;
    %    p_name_strings;
    %    p_ids;
    %    
    %    params;
    %    param_map;
    %
    %   Abstract methods, static
    %
    %    [rpsd,p,w] = psd(nc,p);
    %
    %   Abstract methods, public
    %   
    %    m = mean(nc);
    %    mx = max_limit(obj);
    %    lims = axis_lims(obj);
    %
    
    properties (Constant)
       
        available_distributions = {'Burr Type XII PSD';...
                                    'Gaussian PSD'};
        
    end
    
    properties (Abstract,Constant)
        
        name;
        
    end
    
    
    properties (Abstract, SetAccess = protected)
        
        
        p_name_strings;
        p_ids;
        
        params;
        param_map;

    end
    
    methods (Abstract,Static)

        [rpsd,p,w] = psd(nc,p);
        
    end
    
    methods (Abstract, Access = public)
        
        m = mean(nc);
        mx = max_limit(obj);
        lims = axis_lims(obj);
        
    end
    
    methods (Access = public)
       
        p = get_param(obj,tag)
        p = get_param_vector(obj);
        set_param(obj,tag,value);
        set_param_vector(obj,p);
        
    end
    
end

