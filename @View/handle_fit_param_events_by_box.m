function handle_fit_param_events_by_box(obj,src,evnt)
%HANDLE_FIT_PARAM_EVENTS_BY_BOX Handler for fit_params_changed_by_box
%   Detailed explanation goes here
%
% Parameters
% obj           Calling View instance
% src           A meta.property object describing the object that is the
%               source of the property event (Model in this case)
% evnt          A Fit_params_fit_data object containing information about the event

m = src;
handles = guidata(obj.gui);
tag = evnt.tag;

% get all edit box values
[min, val, max] = m.get_min_val_max(m.get_fit_param_index(tag)); 

% updates
switch tag(end-3:end)
    
    case '_min'
        
        set(handles.([tag(1:end-4) '_sldr']),'Min',min);
        
        % changes in min values that affect psd    
        if strfind(tag,'meanr_min')
   
            obj.update_psd();
   
        end
        
    case '_val'
        
        set(handles.([tag(1:end-4) '_sldr']),'Value',val);
        obj.update_form_factor();
        
        % tags that require psd to update
        if any([strfind(tag,'meanr') strfind(tag,'pdisp')])
   
            obj.update_psd();
            
        end
        
        % tags that require polarization density profile to update
        if any([strfind(tag,'meanr') strfind(tag,'sd') strfind(tag,'pd') strfind(tag,'epds') strfind(tag,'fuzz')])
    
            obj.update_pd();    
    
        end
        
    
    case '_max'
        
        set(handles.([tag(1:end-4) '_sldr']),'Max',max);
        
        % changes in max values that affect psd and pd    
        if strfind(tag,'meanr_max')
   
            obj.update_psd();
            obj.update_pd();
    
        end
    
    
end % switch


end

