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
    
    % Copyright (c) 2015, Otto Virtanen
    % All rights reserved.
    
    properties (Constant)
       
        available_distributions = containers.Map({  'Burr Type XII PSD';
                                                    'Gumbel PSD';
                                                    'Gaussian PSD';
                                                    'Gaussian PSD in volume';
                                                    'Lognormal PSD';
                                                    'Skew normal PSD'},...
                                                 {  @()DST_BurrXII();
                                                    @()DST_Gumbel();
                                                    @()DST_Gaussian();
                                                    @()DST_Gaussian_volume();
                                                    @()DST_Lognrml();
                                                    @()DST_Skewnrml()});
        
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
        n = n_total_params(obj);
        
    end
    
    methods (Access = public)
       
        p = get_param(obj,tag)
        p = get_param_vector(obj);
        set_fixed_vector(obj,pf);
        set_param(obj,tag,value);
        set_param_vector(obj,p);
        set_bounds_vectors(obj,lb,ub);
        
    end
    
end

