function set_all_fit_param(obj,p,format)
%SET_ALL_FIT_PARAMS Sets all the fit parameters
%
% set_all_fit_param(p,format)
%
% Parameters
% p             fit parameter vector: 
%                  sd          Skin depth          1
%                  pd          pd of core          2
%                  epds        Max pd of skin      3
%                  fuzz        Fuzziness           4
%                  amplitude   Amplitude           5
%                  meanr       Mean of the PSD     6
%                  pdist       Polydispersity      7
% format        Either 'literal' or 'fitting' whether the parameters in p
%               can be directly set to Model.fitting_param or they have to
%               be converted from Model.scattered_intensity format to
%               Model.fitting_param format, respectively.

% recalculate fit, pd and psd data with the new parameters before
% converting to UI format

obj.set_fit(p);
obj.set_pd(p);

switch format
    
    case 'literal'
        
        % do nothing
        
    case 'fitting'
        
        p(1) = (1 - p(1)) .* 100; % Skin depth percentage from outside
        p(7) = p(7) ./ p(6) .* 100; % As std / mean * 100
        
    otherwise
        
        error('Unknown format.');
    
end % switch

obj.fit_param(:,2) = num2cell(p);

notify(obj,'all_fit_params_changed');

end

