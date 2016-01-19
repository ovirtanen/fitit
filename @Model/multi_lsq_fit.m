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

nodes = obj.bl.nodes;
ani = obj.bl.active_node_index;

if numel(nodes) == 0
   
    error('No Data_nodes in Batch_loader.');
    
elseif not(any(fitmode == [1 2 3]))
    
    error('Invalid fit mode.');
    
elseif any(fitmode == [2 3]) && isempty(ani)
    
    error('No active mode but fitmode 2 or 3 selected.');
    
end


%% Iterate, fit and update Data_nodes 
% Required for the fit
% handles
% {active_handles}
% {q},{intst},{std}
% nc
% p, pf
% lb,ub
%

p_active = obj.get_total_parameter_vector;
[lb_a,ub_a] = obj.get_total_param_bounds;

switch fitmode
   
    case 1  % Fit all with initial guess saved to the nodes; if nodes are empty; use currently active parameters
        
        for i = node_indices
            
           obj.bl.set_active_node(i);
           obj.initialize_from_data_node(obj.bl.active_node);
           
           [p, std_p] = obj.lsq_fit();
           obj.set_total_parameter_vector(p);
           obj.bl.update_data_node_params(obj.bl.active_node);
           
           prg(i/numel(node_indices));
            
        end
        
    case 2 % Fit all with the initial guess parameters currently loaded to the model
        
        
        for i = node_indices
           
           obj.set_total_parameter_vector(p);
           obj.set_total_bounds(lb_a,ub_a); 
            
           obj.bl.set_active_node(i);
           obj.initialize_from_data_node(obj.bl.active_node);
           
           obj.set_total_parameter_vector(p_active);
           obj.set_total_bounds(lb_a,ub_a);
           
           [p, std_p] = obj.lsq_fit();
           obj.set_total_parameter_vector(p);
           obj.bl.update_data_node_params(obj.bl.active_node);
           
           prg(i/numel(node_indices));
           
        end
        
    case 3 % Use current parameters as guess for the first fit and use the results as guesses for subsequent fits
        
    otherwise
        
        error('Unknown fit mode.');
    
end



end

