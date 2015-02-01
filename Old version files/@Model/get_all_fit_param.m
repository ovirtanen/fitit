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
% param         Fit parameters: 
%                               dr          decay rate          1
%                               epds        Max pd of skin      2
%                               fuzz        Fuzziness           3
%                               amplitude   Amplitude           4
%                               a           Burr parameter a    5
%                               c           Burr parameter c    6
%                               k           Burr parameter k    7

param = obj.fit_param(:,2);
param = cell2mat(param);

switch format
    
    case 'literal'
        
        return;
        
    case 'fitting'
        
        % let's see if we want to process burr parameters or not
        %param(6) = param(6) .* param(5) / 100;  % polydispersity = std / mean
        
    otherwise
        
        error('Unknown format.');
    
    
end % switch

end

