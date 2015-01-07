classdef Model < handle
    %MODEL Model for FitIt
    %   Detailed explanation goes here
    
    properties (SetAccess = private,SetObservable)
        
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
        
        % fit_param structure <6 x 4 double>:
        %
        % dr_min            dr_val          dr_max          dr_chck
        % epds_min          epds_val        epds_max        epds_chck
        % fuzz_min          fuzz_val        fuzz_max        fuzz_chck
        % amplitude_min     amplitude_val   amplitude_max   amplitude_chck
        % meanr_min         meanr_val       meanr_max       meanr_chck
        % pdisp_min         pdisp_val       pdisp_max       pdisp_chck
        
    end % fit parameters
    
    events
        
        all_fit_params_changed;            % sliders, boxes and axes
        fit_params_changed_by_box;         % Requires updating the slider & axes
        fit_params_changed_by_chckbox;     % Requires updating the fit button
        fit_params_changed_by_sldr;        % Requires updating *_val box & axes
        empirical_data_loaded;
        
    end % events
    
    methods (Static)
        
        [intst,rpd,rpsd,psd] = scattered_intensity(q,a,nc,rfrac,vcore,vexc,fuzz,psd_m,psd_w);
        hri = trg2(r,rinc,rp,v,vm)
        hri = trg3(r,rinc,rp,v,vm)
        hri = trg4(r,tau,rp,vm)
        [rc, a] = pd_profile(nc,rhard,tau,vskin,fuzz)
        p = numP(r,a,q)
        p = vnumP(r,w,a,q)
        
        x = snc(x)
        x = rm_nan(x,f)
          
    end
    
    methods (Access = public)
        
        function obj = Model()
            
            keyset = {'dr_min',...
                      'epds_min',...
                      'fuzz_min',...
                      'amplitude_min',...
                      'meanr_min',...
                      'pdisp_min',...
                      'dr_val',...
                      'epds_val',...
                      'fuzz_val',...
                      'amplitude_val',...
                      'meanr_val',...
                      'pdisp_val',...
                      'dr_max',...
                      'epds_max',...
                      'fuzz_max',...
                      'amplitude_max',...
                      'meanr_max',...
                      'pdisp_max',...
                      'dr_chck',...
                      'epds_chck',...
                      'fuzz_chck',...
                      'amplitude_chck',...
                      'meanr_chck',...
                      'pdisp_chck'};
                  
            valueset = num2cell(1:numel(keyset));      
            
            obj.param_map = containers.Map(keyset,valueset);
            
            % Default parametes when the program is initialized
            
            obj.fit_param = {1e-5   1e-3    1e-2    1;...   % decay rate        1
                             0.01   1       1       1;...   % max skin PD       2   
                             0.01   25      100     1;...   % fuzziness         3
                             1e-3   0.3     0.3     1;...   % amplitude         4
                             0      400     1000    1;...   % mean radius       5
                             0.1    5       20      1};     % polydispersity    6
            
            obj.qfit = linspace(0,0.025,200)'; % dummy q for plotting
            obj.nc = 100;                      % collocation points
            
            p = obj.get_all_fit_param('fitting');
            obj.set_fit(p); % sets obj.fit, obj.rpsd, obj.psd
                                                                     
           [~,obj.pd] = obj.pd_profile(obj.nc,p(5),p(1),p(2),p(3));
                
        end % constructor
        
        h = construct_handle(obj,f);
        
        [min,val,max] = get_min_val_max(obj,lin_ind);
        
        [p,exitflag] = lsqfit(obj);
        
        % setters
        
        set_all_fit_param(obj,p,format);
        
        set_empirical_data(obj,data)
        
        set_fit(obj,p);
        
        set_fit_param(obj,tag,value);
        
        set_pd(obj,p);
        
        % getters
        
        v = get_all_fit_param(obj,format);
        
        [lb,ub] = get_bounds(obj,format);
        
        fp = get_fit_param(obj,tag_or_index);
        
        ind = get_fit_param_index(obj,tag);
        
        b  = get_fixed_status(obj);
        
        b = is_data_loaded(obj);
        
    end % public methods
    
    methods (Access = private)
      
        
        
    end % private methods
    
end

