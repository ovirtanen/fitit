function set_all_fit_param(obj,p,format)
%SET_ALL_FIT_PARAMS Sets all the fit parameters
%
% set_all_fit_param(p,format)
%
% Parameters
% p             fit parameter vector: 
%                  
%                  dr          decay rate          1
%                  epds        Max pd of skin      2
%                  fuzz        Fuzziness           3
%                  amplitude   Amplitude           4
%                  meanr       Mean of the PSD     5
%                  pdist       Polydispersity      6
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
        
        p(6) = p(6) ./ p(5) .* 100; % As std / mean * 100
        
    otherwise
        
        error('Unknown format.');
    
end % switch

obj.fit_param(:,2) = num2cell(p);

notify(obj,'all_fit_params_changed');

end

