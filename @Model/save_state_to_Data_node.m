function save_state_to_Data_node(obj,dn)
%SAVE_STATE_TO_DATA_NODE Saves model specific information to a Data_node
%instance
%   
%   save_state_to_Data_node(dn)
%
% Parameters
% dn            Data_node instance where the data will be saved
%
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

Lib.inargtchck(dn,@(x)isa(x,'Data_node'));


%% Collect values from Model

s_model_name = obj.get_active_s_model.name;
dist_name = obj.get_active_s_model.dist.name;

bg_enabled = obj.bg.enabled;

% Change default values only if SLS_Backreflection has been loaded
if not(isempty(obj.sls_br))
   
    sls_br_enabled = [obj.sls_br.enabled];
    
    ri = [obj.sls_br.refr_index];
    wl = [obj.sls_br.w_length];
   
    sls_br_param = struct('ri',num2cell(ri),'wl',num2cell(wl));
 
end

%% Set values to Data_node

dn.s_model_name = s_model_name;
dn.dist_name = dist_name;
dn.bg_enabled = bg_enabled;

if not(isempty(obj.sls_br))
    dn.sls_br_enabled = sls_br_enabled;
    dn.sls_br_param = sls_br_param;
end

dn.total_param_vector = obj.get_total_parameter_vector();

end

