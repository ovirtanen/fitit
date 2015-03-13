classdef DST_Histogram < Distribution & handle
    %DST_HISTOGRAM Histogram PSD for Scattering_model. Can be used to e.g.
    %to load an empirical PSD from particle tracking data etc.
    %
    % obj = DST_Histogram(rpsd,hpsd)
    %
    % Parameters
    % rpsd          Evenly distributed collocation points of the PSD
    % hpsd          Values of the PSD at points rpsd
    
    %
    
    
    properties (Constant)
       
        name = 'Imported PSD';
        
    end
    
    
    properties (SetAccess = protected)
        
        p_name_strings;
        p_ids;
        
        params;
        param_map;

    end
    
    properties (Access = private)
       
        rpsd;
        hpsd;
        w;
        
    end
    
    
    methods (Access = public)

        function obj = DST_Histogram(rpsd,hpsd)
            
            if numel(rpsd) ~= numel(hpsd)
                
                error('Number of collocation points and PSD values has to be the same.');
                
            elseif ~all([min(size(rpsd)) min(size(hpsd))] == [1 1])
                
                error('Both parameters have to be vectors.');
                
            else
                
                obj.rpsd = rpsd(:);
                obj.hpsd = hpsd(:);
                
                obj.w = mean(diff(rpsd));
                
            end % if
            
            
            obj.p_name_strings = {'Shift (nm)'};
            obj.p_ids = {'shft'};
                     
                     
             % Distribution parameters map
            keyset = Scattering_model.param_ids_to_tags(obj.p_ids,'params');
            valueset = num2cell(1:numel(keyset));
            
            obj.param_map = containers.Map(keyset(:),valueset);
            
            
            obj.params = {-1000 0 1000 1};        % Shift of the histogram
                     
        end % constructor
        
        % Because Matlab is crap, it doesn't complain that the static
        % abstract method psd is implemented as class method.
        
        [rpsd,p,w] = psd(obj,nc,p); 
        
        m = mean(obj,nc);
        mx = max_limit(obj);
        lims = axis_lims(obj);
        
    end % public methods

end

