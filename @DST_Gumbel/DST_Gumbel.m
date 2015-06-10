classdef DST_Gumbel < Distribution & handle
    %DST_Gumbel Gumbel PSD for Scattering_model
    
    % Copyright (c) 2015, Otto Virtanen
    % All rights reserved.
    
    properties (Constant)
       
        name = 'Gumbel PSD';
        
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

        function obj = DST_Gumbel()
            
            obj.p_name_strings = {'Position (nm)';...
                                  'Width '};
            obj.p_ids = {'pos';
                         'wdth'};
                     
                     
             % Distribution parameters map
            keyset = Scattering_model.param_ids_to_tags(obj.p_ids,'params');
            valueset = num2cell(1:numel(keyset));
            
            obj.param_map = containers.Map(keyset(:),valueset);
            
            % Distribution paramter default values
            %
            %   {mean_min mean_val mean_max mean_chck;...
            %    std_min  std_val  std_amx  std:chck}
            
            obj.params = {10 300 1000 1;...         % Position
                          1  10  100  1};           % width
                     
        end % constructor
        
        m = mean(obj,nc);
        mx = max_limit(obj);
        lims = axis_lims(obj);
        
    end % public methods

end

