classdef DST_Gaussian < Distribution & handle
    %GAUSSIAN Gaussian PSD for Scattering_model
    
    % Copyright (c) 2015, Otto Virtanen
    % All rights reserved.
    
    properties (Constant)
       
        name = 'Gaussian PSD';
        
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

        function obj = DST_Gaussian()
            
            obj.p_name_strings = {'Mean radius (nm)';...
                                  'Sigma (nm)'};
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
            
            obj.params = {10 300 1000 1;...         % Mean radius
                          1  10  100  1};           % Std
                     
        end % constructor
        
        m = mean(obj,nc);
        mx = max_limit(obj);
        lims = axis_lims(obj);
        n = n_total_params(obj);
        
    end % public methods

end

