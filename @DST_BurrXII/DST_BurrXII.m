classdef DST_BurrXII < Distribution & handle
    %BURRXII Burr Type XII PSD for Scattering_model
    
    properties (Constant)
       
        name = 'Burr Type XII PSD';
        
    end
    
    properties (SetAccess = protected)
        
        p_name_strings;
        p_ids;
        
        params;
        param_map;

    end
    
    methods (Static)
        
        [rpsd,p,w] = psd(nc,mean,sigma);
        d = burrpdf(r,a,c,k);
        m = burr_moments(o,a,c,k);
        
    end
    
    methods (Access = public)

        function obj = DST_BurrXII()
            
            obj.p_name_strings = {'Size parameter a (nm)';...
                                  'Parameter c';...
                                  'Parameter k'};
            obj.p_ids = {'a';
                         'c';
                         'k'};
                     
                     
             % Distribution parameters map
            keyset = Scattering_model.param_ids_to_tags(obj.p_ids,'params');
            valueset = num2cell(1:numel(keyset));
            
            obj.param_map = containers.Map(keyset(:),valueset);
            
            % Distribution paramter default values
            
            obj.params = {15 400 1000 1;...         
                          21 100  100  1;...
                          0.1 1 1 1};           
                     
        end % constructor
        
        m = mean(obj,nc);
        mx = max_limit(obj);
        lims = axis_lims(obj);
        
    end % public methods
    
end

