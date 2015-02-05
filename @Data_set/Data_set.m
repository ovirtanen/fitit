classdef Data_set < handle
    %DATA_SET Class for describing one data set
    %
    %   obj = Data_set(sm)
    %   obj = Data_set(sm,q_exp,i_exp, std_exp)
    %
    %   Parameters
    %   sm              Scattering_model instance
    %   q_exp           Experimental q values as vector
    %   i_exp           Experimental scattered intensity as vector
    %   std_exp         Experimental std of the intensity

    
    
    properties (SetAccess = private)
        
        
        q_mod;
        
        q_exp;
        i_exp;
        std_exp;
        
        
    end
    
    methods (Access = public)
        
        function obj = Data_set(varargin)
             
            switch nargin
               
                case 0 % no experimental data
                    
                   obj.q_exp = [];
                   obj.i_exp = [];
                   obj.std_exp = [];
        
                   obj.q_mod = linspace(0,0.025,200)';    % arbitrary q range
                   
                case 3  % experimental data
                   
                   
                   obj.q_exp = varargin{1};
                   obj.i_exp = varargin{2};
                   obj.std_exp = varargin{3};
                   
                   obj.q_mod = linspace(0,max(obj.q_exp),200)'; 
                   
                otherwise
                    
                    error('Wrong number of input arguments.');
                     
            end % switch
    
            
    
        end % constructor
        
        add_experimental_data(obj,d);
        remove_experimental_data(obj);
        
    end
    
end

