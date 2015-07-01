function l = get_total_free_params(obj)
%GET_TOTAL_FREE_PARAMS Returns logical array indicating which parameters in
%the total parameter vector are not fixed.
%   

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

l = [];

%% Background
bg_enabled = obj.bg.enabled;

if any(bg_enabled)
    
    bg_chcks = cell2mat(obj.bg.params(:,4));
    
    l = [l; logical(bg_chcks(bg_enabled))];
        
end
    
%% Backreflection

brs = obj.sls_br;

if not(isempty(brs)) && any([brs.enabled])
    
    fixed = {brs.eta};
    fixed = cellfun(@(x)x{4},fixed([brs.enabled]));
    
    l = [l; fixed(:)];
    
end

%% Scattering models

for i = 1:numel(obj.s_models)
    
    sm = obj.s_models{i};
    
    lsm = sm.params(:,4);
    ldist = sm.dist.params(:,4);
    t = cell2mat([lsm; ldist]);
    
    l = logical([l;logical(t)]);
    l = not(l);
    
end % for


end

