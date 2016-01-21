function multi_lsq_fit(obj,node_indices,fitmode,prg)
%MULTI_LSQ_FIT Automatic fit on multiple Data_nodes in Batchloader
%   
%   multi_lsq_fit(nodes,fitmode)
%
% Parameters
% nodes_indices Indice vector for Batch_loader.nodes
% fitmode       Iteration mode for the fitting
%                1  Use p and bounds saved in each Data_node as initial guess
%                2  Use p and bounds of the currently loaded Data_node
%                3  Use p and bounds of the currently loaded Data_node for
%                   the first fit, then use the result of the fit as the
%                   initial guess for the adjacent nodes
% prg            Function handle to waitbar()


% Copyright (c) 2015-2016, Otto Virtanen
% All rights reserved.

nodes = obj.model.bl.nodes;
ani = obj.model.bl.active_node_index;

%% Some checks on the inputs

if numel(nodes) == 0
   
    error('No Data_nodes in Batch_loader.');
    
elseif not(any(fitmode == [1 2 3]))
    
    error('Invalid fit mode.');
    
elseif any(fitmode == [2 3]) && isempty(ani)
    
    error('No active selection but fitmode 2 or 3 selected.');
    
elseif not(issorted(node_indices)) && numel(unique(node_indices)) == numel(node_indices) && all(node_indices > 0)
    
    error('Improper node indices list.');
    
end


%% Iterate, fit and update Data_nodes 

% parameters of the currently active node
p_active = obj.model.get_total_parameter_vector;
[lb_a,ub_a] = obj.model.get_total_param_bounds;
fixed = not(obj.model.get_total_free_params());

j = 1; % iteration variable for the progress bar

switch fitmode
   
    case 1  % Fit all with initial guess saved to the nodes; if nodes are empty; use currently active parameters
        
        for i = node_indices
            
           obj.model.bl.set_active_node(i);
           
           if isempty(obj.model.bl.active_node.s_model_name) % crappy check, implement better method later
               
               obj.model.initialize_from_data_node(obj.model.bl.active_node,'onlydata');
               obj.model.set_total_parameter_vector(p_active);
               obj.model.set_total_bounds(lb_a,ub_a);
               obj.model.set_total_fixed_vector(fixed);
               
           else
               
                obj.model.initialize_from_data_node(obj.model.bl.active_node);
           
           end
           
           if all(not(obj.model.get_total_free_params()))
           
               warning('All parameters fixed, skipping node.');
               continue;
               
           end
           
           [p, std_p] = obj.model.lsq_fit();
           obj.model.set_total_parameter_vector(p);
           obj.model.bl.update_data_node_params(obj.model.bl.active_node);
           
           prg(j/numel(node_indices));
           
           j = j + 1;
            
        end
        
    case 2 % Fit all with the initial guess parameters currently loaded to the model
        
        
        for i = node_indices
           
           obj.model.bl.set_active_node(i);
           obj.model.initialize_from_data_node(obj.model.bl.active_node,'onlydata');
           
           obj.model.set_total_parameter_vector(p_active);
           obj.model.set_total_bounds(lb_a,ub_a);
           obj.model.set_total_fixed_vector(fixed);
           
           if all(not(obj.model.get_total_free_params()))
           
               warning('All parameters fixed, skipping node.');
               continue;
               
           end
           
           [p, std_p] = obj.model.lsq_fit();
           obj.model.set_total_parameter_vector(p);
           obj.model.bl.update_data_node_params(obj.model.bl.active_node);
           
           prg(j/numel(node_indices));
           
           j = j + 1;
           
        end
        
    case 3 % Use current parameters as guess for the first fit and use the results as guesses for subsequent fits
        
        ani = obj.model.bl.active_node_index;
        
        pos = ani == node_indices;
        pos = find(pos);
        
        node_indices = node_indices(:)'; % Make sure of the vector orientation
        p = [];
        iter_start = 0;
        
        % check where to start the iteration
        
        if pos == 1 % start from the beginning
            
            % do nothing
            
        elseif pos == numel(node_indices) % start from the last node
            
            node_indices = fliplr(node_indices);
            
        else % start from somewhere in-between
            
            iter_start = node_indices(pos + 1);
            node_indices = [fliplr(node_indices(1:pos)) node_indices(pos+1:end)];
            
        end
        
        % Set the parameters based on the first entry in the list
        
        obj.model.bl.set_active_node(node_indices(1));
        obj.model.initialize_from_data_node(obj.model.bl.active_node,'onlydata');

        obj.model.set_total_parameter_vector(p_active);
        obj.model.set_total_bounds(lb_a,ub_a);
        obj.model.set_total_fixed_vector(fixed);
        
        % fit the first node
        
        if all(not(obj.model.get_total_free_params()))
           
               warning('All parameters fixed, skipping node.');
               
        end

        [p, std_p] = obj.model.lsq_fit();
        p_active = p;       % if starting from a mid-node, propgation to the other direction starts with this guess
        obj.model.set_total_parameter_vector(p);
        obj.model.bl.update_data_node_params(obj.model.bl.active_node);

        prg(j/numel(node_indices));
        
        j = j + 1;
        
        % Iterate through the rest of the nodes
        
        for i = node_indices(2:end)
            
           if all(not(obj.model.get_total_free_params()))
           
               warning('All parameters fixed, skipping node.');
               continue;
               
           end % if
           
           obj.model.bl.set_active_node(i);
           obj.model.initialize_from_data_node(obj.model.bl.active_node,'onlydata');
           
           if i == iter_start % other side of the propagation point
               
               obj.model.set_total_parameter_vector(p_active);
               obj.model.bl.update_data_node_params(obj.model.bl.active_node);
               
           else
               
               obj.model.set_total_parameter_vector(p);
               obj.model.bl.update_data_node_params(obj.model.bl.active_node);
               
           end % if
           
           [p, std_p] = obj.model.lsq_fit();
           obj.model.set_total_parameter_vector(p);
           obj.model.bl.update_data_node_params(obj.model.bl.active_node);
           
           prg(j/numel(node_indices));
           
           j = j + 1;
                       
        end % for
        
    otherwise
        
        error('Unknown fit mode.');
    
end

end

