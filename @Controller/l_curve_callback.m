function l_curve_callback(obj,hObject,callbackdata)
%L_CURVE_CALLBACK Callback for the Tools menu Determine L-Curve item
%   
%   l_curve_callback(hObject,callbackdata)
%
% Determines the L-curve for regularized SM_Free_profile fit, i.e.,
% computes regularized solution for the scattering pattern with different
% regularization parameter lambda values and plots inverse solution norm
% against residual norm on log-log scale. The optimal lambda value is close
% to the corner of the L-curve. Initial guess values are those set by the
% user in the parameter panel.

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

obj.view.disable_f_button();
prev_state = obj.view.switch_enable_panels('off');
drawnow();

wb = waitbar(0,'Calculating L-curve with given initial guesses...');
wb.WindowStyle = 'modal';
%wb.CloseRequestFcn = @(src,callbackdata) beep();
drawnow();

[solnorm, resnorm, lambda, ~] = obj.model.l_curve(8, @(x)wbar(wb,x));

wb.delete();

obj.view.switch_enable_panels(prev_state);
obj.view.update_f_button_status();
drawnow();

obj.view.display_l_curve(solnorm, resnorm,lambda);

end

function wbar(wb,frac)
       
waitbar(frac,wb);
        
 end

