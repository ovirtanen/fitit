function sm_ui_cleanup(obj,sm_label)
%SM_UI_CLEANUP Model specific UI clean up
%   
% sm_ui_cleanup(sm_label)
%
% Parameters
% sm_label          Name of the scattering model
%

l = findobj(obj.view.menu.tools,'Tag','l_curve');

switch sm_label

    case 'Free Profile Model'
   
     % get rid of the checkbox for the regularization parameter
    cb = findobj(obj.view.p_panel,'Tag','lambda_chck');
    cb.delete();
    
    %cb = findobj(obj.view.p_panel,'Tag',['stp' num2str(obj.model.s_models{1}.n) '_chck']);
    %cb = findobj(obj.view.p_panel,'Tag',['stp' num2str(1) '_chck']);
    %cb.Enable = 'off';

    %check whether to enable Tools menu Determine L-Curve item
    if isempty(obj.model.data_sets)
 
        l.Enable = 'off';
        
    else
        
        l.Enable = 'on';

    end
    
end


end

