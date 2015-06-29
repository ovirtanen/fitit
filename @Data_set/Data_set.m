classdef Data_set
    %DATA_SET Class for holding measurement data
    %
    %   obj = Data_set(q_exp,i_exp, std_exp)
    %
    %   Parameters
    %   q_exp           Experimental q values as vector
    %   i_exp           Experimental scattered intensity as vector
    %   std_exp         Experimental std of the intensity

    % Copyright (c) 2015, Otto Virtanen
    % All rights reserved.
    
    
    properties (SetAccess = private)
        
        q_exp;
        i_exp;
        std_exp;
        
        active_handles;
        
    end
    
    methods (Access = public)
        
        function obj = Data_set(q,intst,std)
             
            obj.q_exp = q;
            obj.i_exp = intst;
            obj.std_exp = std;
            
            % Indice array that indicates which handles are necessary to 
            % calculate the total scattered intensity for this dataset.
            obj.active_handles = []; 
    
        end % constructor
        
        set_active_handles(obj,indices);
        
        
    end 
    
end

