classdef Model < handle
    %MODEL Model for FitIt
    %   Detailed explanation goes here
    
    properties (SetObservable)
        
        intensity;          % empirical data
        std;                %       .
        q;                  %       .
        
        qfit;               % q values for the fit
        fit;                % calculated scattering function
        
        rpd                 % collocation points for the pd
        pd;                 % polarization density
        
        rpsd;               % collocation points for the psd
        psd;                % particle size distribution

        
    end
    
    properties (SetAccess = private)
        
        param_map;          % map containing indices for parameters and bounds
        fit_param;          % values for parameters and bounds
        
        % fit_param structure <4 x 8 double>:
        %
        % sd_min            sd_val          sd_max          sd_chck
        % epds_min          epds_val        epds_max        epds_chck
        % fuzz_min          fuzz_val        fuzz_max        fuzz_chck
        % amplitude_min     amplitude_val   amplitude_max   amplitude_chck
        % meanr_min         meanr_val       meanr_max       meanr_chck
        % pdisp_min         pdisp_val       pdisp_max       pdisp_chck
        
    end % fit parameters
    
    events
        
        fit_params_changed;         % Requires updating the slider 
        
    end % events
    
    methods (Access = public)
        
        function obj = Model()
            
            keyset = {'sd_min',...
                      'epds_min',...
                      'fuzz_min',...
                      'amplitude_min',...
                      'meanr_min',...
                      'pdisp_min',...
                      'sd_val',...
                      'epds_val',...
                      'fuzz_val',...
                      'amplitude_val',...
                      'meanr_val',...
                      'pdisp_val',...
                      'sd_max',...
                      'epds_max',...
                      'fuzz_max',...
                      'amplitude_max',...
                      'meanr_max',...
                      'pdisp_max',...
                      'sd_chck',...
                      'epds_chck',...
                      'fuzz_chck',...
                      'amplitude_chck',...
                      'meanr_chck',...
                      'pdisp_chck'};
                  
            valueset = num2cell(1:numel(keyset));      
            
            obj.param_map = containers.Map(keyset,valueset);
            
            % Default parametes when the program is initialized
            
            obj.fit_param = {0      20      100     1;...
                             0      0.2     1       1;...
                             0      25      100     1;...
                             1e-3   0.1     1       1;...
                             0      400     1000    1;...
                             0      5       20      1};
                
        end % constructor
        
        [min,val,max] = get_min_val_max(obj,lin_ind);
        
        set_fit_param(obj,tag,value);
        
        fp = get_fit_param(obj,tag_or_index);
        
        ind = get_fit_param_index(obj,tag);
        
    end % public methods
    
    methods (Access = private)
        
        
        
        v = get_values(obj);
        lb = get_min_bounds(obj);
        hb = get_max_bounds(obj);
        
    end % private methods
    
end

