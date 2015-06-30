function br_edit_box_callback(obj,hObject,callbackdata)
%BR_EDIT_BOX_CALLBACK Callback for SLS_Backreflection parameter edit boxes 
% in FitIt GUI


tag = hObject.Tag;
v = hObject.String;

panel = ancestor(hObject,'uipanel');

target = obj.sls_br(str2double(regexp(tag,'\d','match')));


if isnan(str2double(v))
    
    abort_eb_value();
    
    errstr = 'Parameters have to be numeric.';
    
    errordlg(errstr,'Invalid parameter','modal');
    return;
    
else
    
    v = str2double(v);
    
end %

id = regexp(tag,'\D*','match','once');
type = tag(end-2:end);

sldr = findobj(panel.Children,'Tag', [id '_sldr']);

switch type
    
    case 'min'
        
        if v >= target.get_param([id '_max'])
            
            abort_eb_value();
    
            errstr = 'Minimum limit has to be smaller than maximum limit.';
    
            errordlg(errstr,'Invalid parameter','modal');
            
        elseif v > target.get_param([id '_val'])
            % if minimum is larger than value, push value up to minimum
            
            target.set_param([id '_val'],v);
            target.set_param(tag,v);
            
            val = findobj(panel.Children,'Tag', [id '_val']);
            val.String = num2str(v);
            
            sldr.Min = v;
            sldr.Value = v;
            
        else
            
            target.set_param(tag,v);
            
            sldr.Min = v;
            
        end % if
        
    case 'val'
        
        if any([v < target.get_param([id '_min']) v > target.get_param([id '_max'])])
           
            abort_eb_value();
    
            errstr = 'Value has to respect the limits.';
    
            errordlg(errstr,'Invalid parameter','modal');
            
        else
            
            target.set_param(tag,v);
            
            sldr.Value = v;
            
        end
        
    case 'max'
        
        if v <= target.get_param([id '_min'])
            
            abort_eb_value();
    
            errstr = 'Maximum limit has to be larger than minimum limit.';
    
            errordlg(errstr,'Invalid parameter','modal');
            
        elseif v < target.get_param([id '_val'])
            % if maximum is smaller than value, push value down to maximum
            
            target.set_param([id '_val'],v);
            target.set_param(tag,v);
            
            val = findobj(panel.Children,'Tag', [id '_val']);
            val.String = num2str(v);
            
            sldr.Max = v;
            sldr.Value = v;
    
        else
            
            target.set_param(tag,v);
            
            sldr.Max = v;
            
        end % if
    
        
    otherwise
        
        error('Type not recognized.');
        
end % switch

obj.view.update_axes();

%%% HELPER FUNCTION

    function abort_eb_value()
        % Helper function for resetting the editbox value
        
        v = target.get_param(tag);
        hObject.String = num2str(v);
        
        
    end % abort_eb_value

end

