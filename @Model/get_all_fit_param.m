function param = get_all_fit_param(obj,format)
%GET_ALL_FIT_PARAM Returns all the fit parameters from Model
%
% param = get_all_fit_param(format)
%
% Parameters
% format        Either 'literal' or 'fitting' whether the values are
%               returned like shown in the GUI or in the format that can be
%               used directly for Model.scattered_intensity
% Returns
% param         Fit parameters: sd          Skin depth          1
%                               epds        Excess pd of skin   2
%                               fuzz        Fuzziness           3
%                               amplitude   Amplitude           4
%                               meanr       Mean of the PSD     5
%                               pdist       Polydispersity      6

param = obj.fit_param(:,2);
param = cell2mat(param);

switch format
    
    case 'literal'
        
        return;
        
    case 'fitting'
        
        param(2) = 1 + param(2);
        param(1) = 1 - param(1) ./ 100;
        param(6) = param(6) .* param(5) / 100;  % polydispersity = std / mean
    
    
end % switch

end

