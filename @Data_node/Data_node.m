classdef Data_node < handle
    %DATA_NODE Class for managing data for Batch_loader.
    % Each Data_node instance can contain multiple Data_set instances in order 
    % to represent multiset data.
    %
    %
    % obj = Data_node(filename1, dataset1, filename2, dataset2, ...)
    % 
    % Parameters
    % filename          File name string
    % dataset           Data_set instance
    %
    
    
    % Copyright (c) 2015, Otto Virtanen
    % All rights reserved.
    
    properties (SetAccess = private)
        
        data_sets;
        filenames;
        s_model_name;
        dist_name;
        bg_enabled;
        sls_br_enabled;
        total_param_vector;
        
        isfit;
        issaved;
              
    end
    
    methods (Static)
       
        obj = combine(varargin);
        
    end
    
    methods (Access = public)
        
        function obj = Data_node(varargin)
            
            %% Check input vararing
            
            index = 1:numel(varargin);
            
            ic = cellfun(@ischar,varargin);
            id = cellfun(@(x)isa(x,'Data_set'),varargin);
            
            if not(numel(ic) == numel(id) && numel(ic(ic == 1)) + numel(id(id == 1)) == numel(index))
               
                error('Data_node: Invalid input arguments.');
                
            end
            
            order = [index(ic);index(id)];
            order = order(:);
            
            if not(all(diff(order) == 1))

                error('Data_node: Invalid input arguments.');
                
            end
            
            %% Set initial values for the properties
            
            % Store data as row vector so that they concatenate nicely when
            % using plus (+) operator
            fn = varargin(ic);
            ds = [varargin{id}];
            
            % Sort alphabetically
            [obj.filenames,order] = sort(fn); 
            obj.data_sets = ds(order);
            
            obj.s_model_name = [];
            obj.dist_name = [];
            obj.bg_enabled = [];
            obj.sls_br_enabled = [];
            obj.total_param_vector = [];
            
            obj.isfit = false;
            obj.issaved = false;
                
        end % constructor
        
        function obj = plus(dn1,dn2)
            
            obj = Data_node.combine(dn1,dn2);
            
        end
        
    end
    
end

