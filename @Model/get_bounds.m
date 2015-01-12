function [lb,ub] = get_bounds(obj,format)
%GET_BOUNDS Returns the upper and lower fit bounds
%
% [lb,ub] = get_bounds()
%
% Parameters
% format        Either 'literal' or 'fitting' whether the bounds
%               can be directly used for lsqfit or they have to
%               be converted to Model.scattered_intensity format from
%               Model.fitting_param format, respectively. See
%               get_all_fit_param
%
% Returns
% lb        lower bounds as an array
% ub        upper bounds as an array
%

lb = cell2mat(obj.fit_param(:,1));
ub = cell2mat(obj.fit_param(:,3));

switch format
    
    case 'literal'
        
        % do nothing
        
    case 'fitting'
        
        %lb(6) = lb(6) .* lb(5) ./ 100; 
        
        %ub(6) = ub(6) .* ub(5) ./ 100; 
        
    otherwise
        
        error('Unknown format.');
    
end % switch

f = not(obj.get_fixed_status()); % not fixed

lb = lb(f);
ub = ub(f);

end

