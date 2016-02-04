classdef Data_set < handle
    %DATA_SET Class for holding measurement data
    %
    %   obj = Data_set(q_exp,i_exp, std_exp)
    %   obj = Data_set(q_exp,i_exp, std_exp,s2)
    %
    %   Parameters
    %   q_exp           Experimental q values as vector
    %   i_exp           Experimental scattered intensity as vector
    %   std_exp         Experimental std of the intensity
    %   s2              SAS smearing parameter values for q_exp (variance)

    % Copyright (c) 2015, 2016, Otto Virtanen
    % All rights reserved.
    
    
    properties (SetAccess = private)
        
        % Basic properties
        % q_exp     Nominal q values
        % i_exp     Intensity values at q_exp
        % std_exp   Standard deviations for i_exp
        
        q_exp;
        i_exp;
        std_exp;
        
        % SAS smearing parameters
        % s2            Smearing parameter values (variance) for each nominal q.
        % qs            Integration points for the resolution function. Each
        %               column holds integration points for one nominal q
        %               value. [n x k] double
        % r             Resolution function values for the integration points.
        %               [n x k double]
        % dq            Integration constant for each nominal q value.
        %               [1 x k double]
        % is_smeared    Boolean for easy checking whether the resolution
        %               function affects the data
        
        s2;
        qs;
        r;
        dq;
        is_smeared;
        
        % List indicating which handles in Model.handles apply to this
        % Data_set
        
        active_handles;
        
    end
    
    methods (Static)
       
        r = res_function(q,qn,sigma2);
        [qm,rm,dq,varargout] = res_discretize(qn,s2,n);
        
    end
    
    methods (Access = public)
        
        function obj = Data_set(q,intst,std,varargin)
            
            if not(numel(unique([numel(q) numel(intst) numel(std)])) == 1)
               
                error('Invalid parameters');
                
            end
            
            obj.q_exp = q(:);
            obj.i_exp = intst(:);
            obj.std_exp = std(:);
            
            if nargin == 4
                
                obj.s2 = varargin{1};
                obj.s2 = obj.s2(:);
                
                if numel(obj.s2) ~= numel(obj.q_exp)
                   
                    error('Invalid sigma2 vector.');
                    
                end
                
                % Use 10 point discretization, which should be sufficient
                % according to Pedersen.
                [obj.qs,obj.r,obj.dq] = Data_set.res_discretize(obj.q_exp,obj.s2,10);
                
                obj.is_smeared = true;
                
            elseif nargin > 4
               
                error('Too many parameters');
                
            else
               
                obj.s2 = [];
                obj.qs = [];
                obj.r = [];
                obj.dq = [];
                obj.is_smeared = false;
                
            end
            
            % Indice array that indicates which handles are necessary to 
            % calculate the total scattered intensity for this dataset.
            obj.active_handles = []; 
    
        end % constructor
        
        set_active_handles(obj,indices);
          
    end  % public methods
    
end

