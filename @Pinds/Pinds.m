classdef Pinds < handle
    %PINDS Class for returning parameter indices of the total parameter
    %vector p for a certain state of Model. 
    %
    % The class is not designed for extensive reuse. Always initialize a new
    % instance when Pinds is needed.
    % 
    
    % Copyright (c) 2015, Otto Virtanen
    % All rights reserved.
        
    properties (SetAccess = private)
        
        pind_arrays;
        pind_types;
        n_species;

    end
    
    properties (Access = private)
        
        iterator_index;
        
    end
    
    methods (Access = public)
        
        
        function obj = Pinds(model)
            
            obj.iterator_index = 1;
            
            % number of backgrounds
            ebg = model.bg.enabled;
            nbg = ebg(ebg == true);
            nbg = numel(nbg);

            % number of backreflections
            if not(numel(model.sls_br) == 0)

                ebr = [model.sls_br.enabled];
                nbr = ebr(ebr == true);
                nbr = numel(nbr);

            else

                nbr = 0;

            end
            
            % The number of parameters required for each Scattering_model
            % instance in Model
            n_s_params = cellfun(@(x) x.n_total_params, model.s_models);
            
            pind = (1:nbg+nbr+sum(n_s_params))';
            
            % Backgrounds for all the datasets are stored in a single
            % SM_Background instance. All the backrounds, therefore, have
            % their parameter indices in one array.  Backreflections in
            % contrast have to be stored in different instances, and each
            % of them require their own parameter indice array.
            %
            % double(not(nbg == 0)) returns 0 if there are no enabled
            % backgrounds and otherwise 1 regardless of the number of
            % backgrounds.

            rows = [nbg;... 
                    ones(nbr,1);...
                    n_s_params(:)];
                
            rows(rows == 0) = [];   % Remove possible 0 backgrounds entry    
            
            obj.pind_arrays = mat2cell(pind,rows,1);
            obj.pind_types = [repmat({'SM_Background'},double(not(nbg == 0)),1);...
                             repmat({'SLS_Backreflection'},nbr,1);...
                             repmat({'Scattering_model'},numel(model.s_models),1)];
            
            obj.n_species = double(not(nbg == 0)) + nbr + numel(n_s_params);
            
                         
        end % constructor
        
        [pinds, type] = next(obj);
        [pinds, type] = get(obj,i_species);
        
    end
    
end

