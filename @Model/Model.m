classdef Model < handle
    %MODEL Model class for FitIt
    %   
    %   obj = Model(ds,sm)
    %
    %   Parameters
    %   ds          Reference to a Data_set instance
    %   sm          Reference to a Scattering_model instance
    %
    %
    %


    
    properties (SetAccess = private)
        
        
        data_sets;
        s_models;
        bg;
        
    end
    
    properties (Access = private)
        
        active_s_model;
        
    end
    
    methods (Access = public)
        
        function obj = Model(ds,sm)
            
            obj.active_s_model = 1;
            obj.data_sets = ds;
            obj.s_models = sm;
            obj.bg = SM_Background();
            
        end % constructor
        
        add_data_set(obj,ds);
        sm = get_active_s_model(obj);
        set_active_s_model(obj,asm);
        i_mod = total_scattered_intensity(obj,nc,q);
        p = get_total_param_vector(obj,sm);
        
    end % public methods
    
end

