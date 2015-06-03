function load_data_set_callback(obj,hObject,callbackdata)
%LOAD_DATA_SET_CALLBACK Callback for loading datasets
%   

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

ms = [];
switch hObject.Tag;
    
    case 'single_ds_loader'
        
        ms = 'off';
        
    case 'multiple_ds_loader'
        
        error('Multiple loading is not supported yet.');
        %ms = 'on';
        
    otherwise
        
        error('Tag not recognized/supported.');
    
end % switch

try 
    
    d = obj.import_data(ms); % d contains only one data set for now
    
catch ME
   
    if strcmp(ME.message,'Open dialog cancelled.')
        
        return;  
        
    elseif strcmp(ME.message,'Data structure not recognized.')
        
        errstr = 'Data file does not seem to have three columns. There should be only three columns: q(nm^(-1)), intensity and std.';
    
        errordlg(errstr,'Invalid parameter','modal');
        
        return;
        
    elseif strcmp(ME.message,'No numeric data recognized.')
        
        errstr = 'Data file does not seem to contain numeric data.';
    
        errordlg(errstr,'Invalid parameter','modal');
        
        return;
        
    else rethrow(ME)
        
    end % if
    
end % try-catch

switch ms
    
    %case 'on' % add data set if multiselect on
        
    %    obj.model.remove_exp_data();
    %    obj.add_data_set_to_model(d);
        
    case 'off'
        
       obj.view.delete_g_sources_in_si_axes();
       obj.model.remove_experimental_data();
       
       % check whether STD is included
       data = d{1};
       [r,c] = size(data);
       
       if c == 2
           
           % add STD  = 1
           data = [data ones(r,1)];
           
       end % if
       
       data = rm_neg(data);
       
       obj.add_data_set_to_model(data);
       
       obj.view.initialize_g_sources_for_data_set(obj.model.data_sets(1));
       
    otherwise
        
        error('Data loading error.');
        
end % switch

obj.view.update_axes;

obj.view.update_f_button_status();

% Check for SM_Free_profile
l = findobj(obj.view.menu.tools,'Tag','l_curve');
if any(cellfun(@(x)isa(x,'SM_Free_profile'),obj.model.s_models))
   
    l.Enable = 'on';
    
else
    
    l.Enable = 'off';
    
end

end

function d = rm_neg(d)
% removes negative intensity values from the data

f = d(:,2) > 0;

s = size(d);

switch s(2)
   
    case 2
        
        d1 = d(:,1);
        d2 = d(:,2);
        
        d = [d1(f) d2(f)];
        
    case 3
        
        d1 = d(:,1);
        d2 = d(:,2);
        d3 = d(:,3);
        
        d = [d1(f) d2(f) d3(f)];
        
    otherwise
        
        error('Invalid data structure.');
    
end


end


