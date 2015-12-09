classdef Data_node < handle
    %DATA_NODE Class for managing data for Batch_loader.
    % Each Data_node instance can contain multiple Data_set instances in order 
    % to represent multiset data.
    %
    %
    % obj = Data_node(filepath1, dataset1, filepath2, dataset2, ...)
    % 
    % Parameters
    % filename          Filepath string
    % dataset           Data_set instance
    %
    %
    % Note: Even though FitIt could accommodate multiple scattering models,
    % Data_node supports only one scattering model in Model.data_sets
    % variable. Generalization has to be considered, if multiple scattering
    % models will be seriously implemented in the future.
    %
    %
    
    % Copyright (c) 2015, Otto Virtanen
    % All rights reserved.
    
    properties (SetAccess = private)
        
        data_sets;
        filenames;
        filedirs;
         
    end
    
    properties(Access = public)
        
        s_model_name;
        dist_name;
        
        bg_enabled;
        sls_br_enabled;
        
        sls_br_param;           % struct with fields ri and wl
        total_param_vector;
        
        isfit;
        issaved;
        
    end
    
    methods (Static)
       
        obj = combine(varargin)
        dna = name_sort(dna);
        dna = ungroup(dn)
        
    end
    
    methods (Access = public)
        
        function obj = Data_node(varargin)
            
            % object array initialization, return an uninialized instance
            if nargin == 0 
                
                return;
                
            end
            
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
            fp = varargin(ic);
            ds = [varargin{id}];
            
            [p,fn,ext] = cellfun(@fileparts,fp,'UniformOutput',false);
            fn = strcat(fn,ext);
            
            % Sort alphabetically
            [obj.filenames,order] = sort(fn); 
            obj.filedirs = p(order);
            obj.data_sets = ds(order);
            
            obj.s_model_name = '';
            obj.dist_name = '';
            obj.bg_enabled = false(size(obj.data_sets));
            obj.sls_br_enabled = false(size(obj.data_sets));
            obj.sls_br_param = struct('ri',num2cell(NaN(size(obj.data_sets))),'wl',num2cell(NaN(size(obj.data_sets))));
            obj.total_param_vector = NaN;
            
            obj.isfit = false;
            obj.issaved = false;
                
        end % constructor
         
        function obj = plus(dn1,dn2)
            
            obj = Data_node.combine(dn1,dn2);
            
        end
       
        function [b,n] = ismultinode(obj)
           
            n = numel(obj.data_sets);
            
            if n > 1
                
                b = true;
                
            else
                
                b = false;
                
            end
            
        end
        
    end
    
    methods % SETTERS
        
        function set.s_model_name(obj,name)

            if ischar(name) 

                obj.s_model_name = name;

            else

                error('Invalid input argument');

            end % if

        end % function
        
        function set.dist_name(obj,name)
            
            if ischar(name)

                obj.dist_name = name;

            else

                error('Invalid input argument');

            end % if
            
        end
        
        function set.bg_enabled(obj,b)
            
            if islogical(b) && numel(b) == numel(obj.data_sets)
               
                obj.bg_enabled = b;
                
            else
                
                error('Invalid input argument');
                
            end
            
        end
        
        function set.sls_br_enabled(obj,b)
            
            if islogical(b) && numel(b) == numel(obj.data_sets)
               
                obj.sls_br_enabled = b;
                
            else
                
                error('Invalid input argument');    
                
            end
            
            
        end
        
        function set.sls_br_param(obj,param)
            
            if isstruct(param) && numel(param) == numel(obj.data_sets) && all(strcmp({'ri';'wl'},fieldnames(param)))
               
                obj.sls_br_param = param;
                
            else
                
                error('Invalid input argument');    
                
            end
            
        end
        
        function set.total_param_vector(obj,p)
            
            if isnumeric(p) && isvector(p)
               
                obj.total_param_vector = p;
                
            else
                
                error('Invalid input argument');    
                
            end
            
        end
        
        function set.isfit(obj,b)
            
            if islogical(b) && numel(b) == 1
               
                obj.isfit = b;
                
            else
                
                error('Invalid input argument');    
                
            end
            
        end
        
        function set.issaved(obj,b)
            
            if islogical(b) && numel(b) == 1
               
                obj.issaved = b;
                
            else
                
                error('Invalid input argument');    
                
            end
            
        end
    end
    
end

