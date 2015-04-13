function edit_box_callback(obj,hObject,callbackdata)
%EDIT_BOX_CALLBACK Callback for parameter edit boxes in FitIt GUI
%   
%   edit_box_callback(hObject,callbackdata) does a primitive validity check
%   for the user supplied value and if it passes, updates the model
%   parameter with the new value. If the value is invalid, the old value
%   will be retrieved from the model and rendered.
%

tag = hObject.Tag;
v = hObject.String;

panel = ancestor(hObject,'uipanel');

target = [];

switch panel.Tag
    
    case 'bg_panel'
        
        target = obj.model.bg();
        
    case 'sm_panel'
        
        target = obj.model.get_active_s_model();
        
    case 'dist_panel'
        
        sm = obj.model.get_active_s_model();
        target = sm.dist;
        
end % switch



if isnan(str2double(v))
    
    abort_eb_value();
    
    errstr = 'Parameters have to be numeric.';
    
    errordlg(errstr,'Invalid parameter','modal');
    return;
    
else
    
    v = str2double(v);
    
end %

id = tag(1:end-4);
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

%obj.view.switch_enable_panels('off');
obj.view.update_axes();
%obj.view.switch_enable_panels('on');

%%% HELPER FUNCTION

    function abort_eb_value()
        % Helper function for resetting the editbox value
 
        v = target.get_param(tag);
        hObject.String = num2str(v);
        
        
    end % abort_eb_value

end

