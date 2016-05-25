classdef DST_Gaussian_volume < Distribution & handle
    %GAUSSIAN Gaussian PSD in volume for Scattering_model
    
    % Copyright (c) 2015,2016 Otto Virtanen
    % All rights reserved.
    
    properties (Constant)
       
        name = 'Gaussian PSD in volume';
        
    end
    
    
    properties (SetAccess = protected)
        
        p_name_strings;
        p_ids;
        
        params;
        param_map;

    end
    
    methods (Static)
        
        [rpsd,p,w] = psd(nc,p);
        
    end
    
    methods (Access = public)

        function obj = DST_Gaussian_volume()
            
            obj.p_name_strings = {'Mean volume (nm^3)';...
                                  'PDI (%)'};
            obj.p_ids = {'mean';
                         'std'};
                     
                     
             % Distribution parameters map
            keyset = Scattering_model.param_ids_to_tags(obj.p_ids,'params');
            valueset = num2cell(1:numel(keyset));
            
            obj.param_map = containers.Map(keyset(:),valueset);
            
            % Distribution paramter default values
            %
            %   {mean_min mean_val mean_max mean_chck;...
            %    std_min  std_val  std_amx  std:chck}
            
            obj.params = {1e5 1e7 1e9 1;...         % Mean volume
                          1  10  100  1};           % PDI
                     
        end % constructor
        
        m = mean(obj,nc);
        mx = max_limit(obj);
        lims = axis_lims(obj);
        n = n_total_params(obj);
        
    end % public methods

end

