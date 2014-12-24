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
        
        nc;                 % number of collocation points for pd & psd

        
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
        
        fit_params_changed_by_box;         % Requires updating the slider & axes
        fit_params_changed_by_sldr;        % Requires updating *_val box & axes
        
    end % events
    
    methods (Static)
        
        [intst,rpd,rpsd,psd] = scattered_intensity(q,a,nc,rfrac,vcore,vexc,fuzz,psd_m,psd_w);
        hri = trg2(r,rinc,rp,v,vm)
        [rc, a] = pd_profile(nc,rhard,rfrac,vcore,vexc,sigma)
        p = numP(r,a,q)
          
    end
    
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
            
            obj.fit_param = {0      20     100     1;...
                             0      0       1       1;...
                             0      25      100     1;...
                             1e-3   1       1       1;...
                             0      400     1000    1;...
                             0      5       20      1};
            
            obj.qfit = linspace(0,0.025,200)'; % dummy q for plotting
            obj.nc = 50;
            
            [obj.fit,~,obj.rpsd,obj.psd] = obj.scattered_intensity(obj.qfit,...
                                                                         obj.fit_param{10},...
                                                                         obj.nc,...
                                                                         1-obj.fit_param{7}/100,...
                                                                         1,...
                                                                         1+obj.fit_param{8},...
                                                                         obj.fit_param{9},...
                                                                         obj.fit_param{11},...
                                                                         obj.fit_param{12} .* obj.fit_param{11} / 100);
                                                                     
           [obj.rpd,obj.pd] = obj.pd_profile(obj.nc,obj.fit_param{11},1-obj.fit_param{7}/100,1,1+obj.fit_param{8},obj.fit_param{9});
                
        end % constructor
        
        [min,val,max] = get_min_val_max(obj,lin_ind);
        
        set_fit(obj,p);
        
        set_fit_param(obj,tag,value);
        
        set_pd(obj,p);
        
        fp = get_fit_param(obj,tag_or_index);
        
        ind = get_fit_param_index(obj,tag);
        
        v = get_all_fit_param(obj,format);
        lb = get_min_bounds(obj);
        hb = get_max_bounds(obj);
        
    end % public methods
    
    methods (Access = private)
      
        
        
    end % private methods
    
end

