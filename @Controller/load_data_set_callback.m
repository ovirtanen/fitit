function load_data_set_callback(obj,hObject,callbackdata)
%LOAD_DATA_SET_CALLBACK Callback for loading datasets
%   

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.


%% Import the raw data

ms = [];
switch hObject.Tag;
    
    case 'single_ds_loader'
        
        ms = 'off';
        
    case 'multiple_ds_loader'
        
        ms = 'on';
        
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

%% Clean up data 

data = std_chck(d);
data = rm_neg(data);

obj.view.delete_g_sources_in_si_axes();
obj.model.remove_experimental_data();

%% Initialize according to the number of datasets

switch ms
    
    case 'on'
        
       for i = 1 : numel(data)
          
        obj.add_data_set_to_model(data{i});
       
        obj.view.initialize_g_sources_for_data_set(obj.model.data_sets(i));
           
       end
       
        
    case 'off'
        
       data = data{1};
       
       obj.add_data_set_to_model(data);
       
       obj.view.initialize_g_sources_for_data_set(obj.model.data_sets(1));
       
    otherwise
        
        error('Data loading error.');
        
end % switch

obj.view.update_axes;

obj.view.update_f_button_status();

%% Check for SM_Free_profile
l = findobj(obj.view.menu.tools,'Tag','l_curve');
if any(cellfun(@(x)isa(x,'SM_Free_profile'),obj.model.s_models))
   
    l.Enable = 'on';
    
else
    
    l.Enable = 'off';
    
end

end

function d = std_chck(d)
   % check whether STD is included and if not, add STD = 1

   dcols = cellfun(@(x)size(x,2), d);

   std_missing = dcols == 2;

   if any(std_missing)

       f = @(x) [x ones(size(x,1),1)];
       d = cellfun(f,d(std_missing),'UniformOutput',false);

   end

end

function d = rm_neg(d)
% removes negative intensity values from the data

for i = 1 : numel(d)
   
    di = d{i};
    
    q = di(:,1);
    intst = di(:,2);
    std = di(:,3);
    
    f = intst > 0;
    
    di = [q(f) intst(f) std(f)];
    d{i} = di;
    
    
end

end


