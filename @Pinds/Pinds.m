classdef Pinds < handle
    %PINDS Class for returning parameter indices of the total parameter
    %vector p for a certain state of Model. 
    %
    %
    % 
    
    % Copyright (c) 2015, Otto Virtanen
    % All rights reserved.
        
    properties (SetAccess = private)
        
        pind_arrays;
        pind_types;
        
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
            rows = [ones(nbg,1);...
                    ones(nbr,1);...
                    n_s_params(:)];
            
            obj.pind_arrays = mat2cell(pind,rows,1);
            obj.pind_types = [repmat({'SM_Background'},nbg,1);...
                             repmat({'SLS_Backreflection'},nbr,1);...
                             repmat({'Scattering_model'},numel(model.s_models),1)];
            
            
        end % constructor
        
        [pinds, type] = next(obj);
        [pinds, type] = get(obj,i_species);
        
    end
    
end

