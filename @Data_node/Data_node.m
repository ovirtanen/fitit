classdef Data_node < handle
    %DATA_NODE Class for managing data for Batch_loader
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
            
            obj.filenames = varargin(ic)';
            obj.data_sets = [varargin{id}]';
            
            obj.s_model_name = [];
            obj.dist_name = [];
            obj.bg_enabled = [];
            obj.sls_br_enabled = [];
            obj.total_param_vector = [];
                
        end
        
    end
    
end

