classdef Model < handle
    %MODEL Model class for FitIt
    %   
    %   obj = Model(sm)
    %
    %   Parameters
    %   sm          Reference to a Scattering_model instance
    %
    %
    %

    % Copyright (c) 2015, Otto Virtanen
    % All rights reserved.

    
    properties (SetAccess = private)
        
        data_sets;          % Empirical data
        s_models;           % All the scattering models
        bg;                 % Background SM
        sls_br;             % SLS backreflection object
        
        handles;           % Cell array holding all the relevant handles 
                           % to calculate total scattered intensity
        
    end
    
    properties (Access = private)
        
        active_s_model;
        
        
    end
    
    methods (Static)
       
        c = chi2(intst,std,p,handles);
        c = chi2reg(i_exp,std,p,handles,regh);
        p = get_total_s_model_param_vector(sm);
        p = p0_to_p(p0,p,pf);
        
    end
    
    methods (Access = public)
        
        function obj = Model(sm)
            
            obj.active_s_model = 1;
            obj.data_sets = [];
            obj.s_models = {sm};
            obj.bg = SM_Background();
            obj.sls_br = [];
            
            obj.update_handles();
            
        end % constructor
        
        % OTHER PUBLIC
        
        add_data_set(obj,ds);
        sm = get_active_s_model(obj);
        p = get_total_param_vector(obj);
        l = get_total_free_params(obj);
        [lb,ub] = get_total_param_bounds(obj);
        [solnorm, resnorm, lamda, pc] = l_curve(obj,npoints,prg);
        p = lsq_fit(obj,options);
        %set_active_s_model(obj,asm);
        i_mod = total_scattered_intensity(obj,nc,q,varargin);
        initialize_sls_backreflection(obj,ri,wl,eta,fixed);
        function remove_sls_backreflection(obj)
           
            obj.sls_br = [];
            
        end
        remove_experimental_data(obj);
        replace_s_model(obj,sm);
        update_handles(obj);
        
    end % public methods
    
end

