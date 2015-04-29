function l = get_total_free_params(obj)
%GET_TOTAL_FREE_PARAMS Returns logical array indicating which parameters in
%the total parameter vector are not fixed.
%   

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

l = logical(obj.bg.get_param('bg_chck'));

if numel(obj.s_models) == 1
    
    lsm = obj.s_models.params(:,4);
    ldist = obj.s_models.dist.params(:,4);
    t = cell2mat([lsm; ldist]);
    
    l = [l;logical(t)];   % fixed parameters
    l = not(l);
    
    return;
    
end

for i = 1:numel(obj.s_models)
    
    sm = obj.s_models(i);
    
    lsm = sm.params(:,4);
    ldist = sm.dist.params(:,4);
    t = cell2mat([lsm; ldist]);
    
    l = logical([l;logical(t)]);
    l = not(l);
    
end % for


end

