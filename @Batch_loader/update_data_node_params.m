function update_data_node_params(obj,dn)
%UPDATE_DATA_NODE_PARAMS Collects the current parameters from Model and
%updates the given Data_node instance
%   Detailed explanation goes here
%
% update_data_node_params(dn)
%
% Parameters
% dn            Data_node instance whose parameters will be updated
%
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.


%% Collect data from Model

m = obj.model;

smn = m.get_active_s_model().name;
distn = m.get_active_s_model().dist.name;

p = m.get_total_parameter_vector();
[lb,ub] = m.get_total_param_bounds();
f = m.get_total_free_params();
bg_e = m.bg.enabled;

if not(numel(m.sls_br) == 0)
    
    sls_br_e = [m.sls_br.enabled];
    
else

    sls_br_e = false(size(m.data_sets));
    
end

%% Update data in Data_node

dn.s_model_name = smn;
dn.dist_name = distn;

dn.total_param_vector = p;
dn.total_param_bounds = [lb ub];
dn.total_fixed = f;

dn.bg_enabled = bg_e;
dn.sls_br_enabled = sls_br_e;

if any(sls_br_e)
    
    dn.sls_br_param = struct('ri',num2cell([m.sls_br.refr_index]),'wl',num2cell([m.sls_br.w_length]));

end

        

end

