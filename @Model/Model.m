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
        
        q_fit;              % q values for plotting
        
        q_br;               % back reflected q
        eta;                % fraction of backreflected intensity
        
        data_sets;
        s_models;
        bg;
        
    end
    
    properties (Access = private)
        
        active_s_model;
        
    end
    
    methods (Static)
       
        c = chi2(intst,std,p,handles);
        p = get_total_s_model_param_vector(sm);
        p = p0_to_p(p0,p,pf);
        qbr = q_brefl(q,n,lambda);
        
    end
    
    methods (Access = public)
        
        function obj = Model(sm)
            
            obj.q_fit = linspace(0.0001,0.025,200)';
            
            obj.q_br = [];
            obj.eta = [];
 
            obj.active_s_model = 1;
            obj.data_sets = [];
            obj.s_models = {sm};
            obj.bg = SM_Background();
            
        end % constructor
        
        % OTHER PUBLIC
        
        add_data_set(obj,ds);
        sm = get_active_s_model(obj);
        p = get_total_param_vector(obj);
        l = get_total_free_params(obj);
        [lb,ub] = get_total_param_bounds(obj);
        p = lsq_fit(obj,options);
        %set_active_s_model(obj,asm);
        i_mod = total_scattered_intensity(obj,nc,q,varargin);
        remove_experimental_data(obj);
        replace_s_model(obj,sm);
        
    end % public methods
    
end

