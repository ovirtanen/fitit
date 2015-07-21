function [lb,ub] = get_total_param_bounds(obj)
%GET_TOTAL_PARAM_BOUNDS Lower and upper bounds for the total parameter
%vector

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

lb = [];
ub = [];

%% Background

bg_enabled = obj.bg.enabled;

if any(bg_enabled)
    
    lb_bg = cell2mat(obj.bg.params(:,1));
    ub_bg = cell2mat(obj.bg.params(:,3));
    
    lb = [lb; lb_bg(bg_enabled)];
    ub = [ub, ub_bg(bg_enabled)];
        
end

%% Backreflection

brs = obj.sls_br;

if not(isempty(brs)) && any([brs.enabled])
    
    etas = {brs.eta};
    
    lb_br = cellfun(@(x)x{1},etas([brs.enabled]));
    ub_br = cellfun(@(x)x{3},etas([brs.enabled]));
    
    lb = [lb; lb_br(:)];
    ub = [ub; ub_br(:)];
    
end

%% Scattering models

for i = 1:numel(obj.s_models)
    
    sm = obj.s_models{i};
    
    lb = [lb; sm.params(:,1); sm.dist.params(:,1)];
    ub = [ub; sm.params(:,3); sm.dist.params(:,3)];
   
end % for

lb = cell2mat(lb);
ub = cell2mat(ub);

end

