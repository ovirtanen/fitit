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
%                               pd          pd of core          2
%                               epds        Max pd of skin      3
%                               fuzz        Fuzziness           4
%                               amplitude   Amplitude           5
%                               meanr       Mean of the PSD     6
%                               pdist       Polydispersity      7

param = obj.fit_param(:,2);
param = cell2mat(param);

switch format
    
    case 'literal'
        
        return;
        
    case 'fitting'
        
        param(1) = 1 - param(1) ./ 100;
        param(7) = param(7) .* param(6) / 100;  % polydispersity = std / mean
    
    
end % switch

end

