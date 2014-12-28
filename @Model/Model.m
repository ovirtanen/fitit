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
        
        % fit_param structure <7 x 4 double>:
        %
        % sd_min            sd_val          sd_max          sd_chck
        % pd_min            pd_val          pd_max          pd_chck
        % epds_min          epds_val        epds_max        epds_chck
        % fuzz_min          fuzz_val        fuzz_max        fuzz_chck
        % amplitude_min     amplitude_val   amplitude_max   amplitude_chck
        % meanr_min         meanr_val       meanr_max       meanr_chck
        % pdisp_min         pdisp_val       pdisp_max       pdisp_chck
        
    end % fit parameters
    
    events
        
        fit_params_changed_by_box;         % Requires updating the slider & axes
        fit_params_changed_by_chckbox;        % Requires updating the fit button
        fit_params_changed_by_sldr;        % Requires updating *_val box & axes
        empirical_data_loaded;
        
    end % events
    
    methods (Static)
        
        [intst,rpd,rpsd,psd] = scattered_intensity(q,a,nc,rfrac,vcore,vexc,fuzz,psd_m,psd_w);
        hri = trg2(r,rinc,rp,v,vm)
        hri = trg3(r,rinc,rp,v,vm)
        [rc, a] = pd_profile(nc,rhard,rfrac,vcore,vexc,sigma)       % pd_profile has a problem. See documentation.
        p = numP(r,a,q)
          
    end
    
    methods (Access = public)
        
        function obj = Model()
            
            keyset = {'sd_min',...
                      'pd_min',...
                      'epds_min',...
                      'fuzz_min',...
                      'amplitude_min',...
                      'meanr_min',...
                      'pdisp_min',...
                      'sd_val',...
                      'pd_val',...
                      'epds_val',...
                      'fuzz_val',...
                      'amplitude_val',...
                      'meanr_val',...
                      'pdisp_val',...
                      'sd_max',...
                      'pd_max',...
                      'epds_max',...
                      'fuzz_max',...
                      'amplitude_max',...
                      'meanr_max',...
                      'pdisp_max',...
                      'sd_chck',...
                      'pd_chck',...
                      'epds_chck',...
                      'fuzz_chck',...
                      'amplitude_chck',...
                      'meanr_chck',...
                      'pdisp_chck'};
                  
            valueset = num2cell(1:numel(keyset));      
            
            obj.param_map = containers.Map(keyset,valueset);
            
            % Default parametes when the program is initialized
            
            obj.fit_param = {0      100     100     1;...   % sd                1
                             0      1       1       1;...   % PD                2
                             0      1       1       1;...   % max skin PD       3   
                             0      25      100     1;...   % fuzziness         4
                             1e-3   1       1       1;...   % amplitude         5
                             0      400     1000    1;...   % mean radius       6
                             0      5       20      1};     % polydispersity    7
            
            obj.qfit = linspace(0,0.025,200)'; % dummy q for plotting
            obj.nc = 100;                      % collocation points
            
            p = obj.get_all_fit_param('fitting');
            obj.set_fit(p); % sets obj.fit, obj.rpsd, obj.psd
                                                                     
           [~,obj.pd] = obj.pd_profile(obj.nc,p(6),p(1),p(2),p(3),p(4));
                
        end % constructor
        
        [min,val,max] = get_min_val_max(obj,lin_ind);
        
        % setters
        
        set_empirical_data(obj,data)
        
        set_fit(obj,p);
        
        set_fit_param(obj,tag,value);
        
        set_pd(obj,p);
        
        % getters
        
        v = get_all_fit_param(obj,format);
        
        [lb,ub] = get_bounds(obj);
        
        fp = get_fit_param(obj,tag_or_index);
        
        ind = get_fit_param_index(obj,tag);
        
        b  = get_fixed_status(obj);
        
        b = is_data_loaded(obj);
        
    end % public methods
    
    methods (Access = private)
      
        
        
    end % private methods
    
end

