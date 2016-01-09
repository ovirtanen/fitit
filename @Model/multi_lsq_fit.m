function multi_lsq_fit(obj,node_indices,fitmode,varargin)
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


% Copyright (c) 2015-2016, Otto Virtanen
% All rights reserved.

if numel(obj.bl.nodes) == 0
   
    error('No Data_nodes in Batch_loader.');
    
elseif not(any(fitmode == [1 2 3]))
    
    error('Invalid fit mode.');
    
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




end

