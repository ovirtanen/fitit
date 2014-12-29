function [p,exitflag,jacobian] = lsqfit(obj)
%LSQFIT Least squares fit on empirical data
%
% p = fit() uses lsqcurvefit of the Optimization Toolbox to find
% parameters p that best fit the empirical scattering trace
%
% Returns
% p         output form lsqcurvefit 
% exitflag  lsqcurvefit exit flag
% jacobian  jacobian matrix for the fit parameters
%

params = obj.get_all_fit_param('fitting');
free = not(obj.get_fixed_status());
x0 = params(free);       % Only free parameters go to initial values 

[lb,ub] = obj.get_bounds('fitting');

fun = obj.construct_handle();

[p,~,~,exitflag,~,~,jacobian] = lsqcurvefit(fun,x0,obj.q,obj.intensity,lb,ub);

params(free) = p; % put the fitted parameters back to the parameter vector
p = params;

end

