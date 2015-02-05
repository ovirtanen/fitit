function [lb,ub] = get_total_param_bounds(obj)
%GET_TOTAL_PARAM_BOUNDS Lower and upper bounds for the total parameter
%vector


lb = obj.bg.get_param('bg_min');
ub = obj.bg.get_param('bg_max');

if numel(obj.s_models) == 1
    
    lb = [lb; obj.s_models.params(:,1); obj.s_models.dist.params(:,1)];
    ub = [ub; obj.s_models.params(:,3); obj.s_models.dist.params(:,3)];
    
    lb = cell2mat(lb);
    ub = cell2mat(ub);
    
    return;
    
end % if

for i = 1:numel(obj.s_models)
    
    sm = obj.s_models(i);
    
    lb = [lb; sm.params(:,1); sm.dist.params(:,1)];
    ub = [ub; sm.params(:,3); sm.dist.params(:,3)];
   
end % for

lb = cell2mat(lb);
ub = cell2mat(ub);

end

