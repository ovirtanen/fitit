function update_push_buttons(obj)
%UPDATE_PUSH_BUTTONS Sets the Batch Loader GUI pushbuttons' Enable property
%according to Model and GUI status
%
%   update_push_buttons(obj)
%
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

btns = obj.push_buttons;
tags = arrayfun(@(x)x.Tag,btns,'UniformOutput',false);

indices = obj.last_t_indices;

% no selection but data loaded
if isempty(indices) && not(isempty(obj.view.model.bl.nodes))
    
    f = strcmp('import_data_btn',tags) ... 
        | strcmp('set_path_btn',tags);
    
    % data is loaded and discard all has been selected in Discard Options
    if obj.booleans.discard_all
       
        f = f | strcmp('discard_data_btn',tags);
        
    end
    
    % data is loaded and fit all has been selected in Batch fitting Options
    if obj.booleans.fit_all && any([ obj.booleans.p_use_original obj.booleans.p_use_active])
       
        f = f | strcmp('fit_btn',tags);
        
    end
    
    set(btns(f),'Enable','on');
    set(btns(not(f)),'Enable','off');
    
    return;

% No data, or invalid selection all except Import Data and Set Path disabled
elseif (isempty(obj.view.model.bl.nodes)) || any(indices(:,2) ~= 1)
   
    f = strcmp('import_data_btn',tags) ... 
        | strcmp('set_path_btn',tags);
    
    set(btns(f),'Enable','on');
    set(btns(not(f)),'Enable','off');
    
    return;

% One Filename row selected    
elseif numel(indices) == 2
       
    f = strcmp('import_data_btn',tags) ... 
        | strcmp('set_path_btn',tags) ...
        | strcmp('fit_btn',tags)...
        | strcmp('discard_data_btn',tags) ...
        | strcmp('save_now_btn',tags);
    
    % Check if Multinode has been selected
    
    rn = obj.file_table.RowName;
    nn = rn(indices(1));
    
    if obj.view.model.bl.nodes(str2double(nn)).ismultinode()
        
        f = f | strcmp('ungroup_to_datasets_btn',tags);
        
    end
    
    
    set(btns(f),'Enable','on');
    set(btns(not(f)),'Enable','off');    

    
% Multiple Filename rows selected    
elseif numel(indices) > 2
    
    f = strcmp('import_data_btn',tags) ... 
        | strcmp('set_path_btn',tags) ...
        | strcmp('group_to_multiset_btn',tags) ...
        | strcmp('discard_data_btn',tags) ...
        | strcmp('save_now_btn',tags);
    
    
    %  fit only selected all has been selected in Batch fitting Options
    if (obj.booleans.fit_all && not(obj.booleans.p_propagate)) || (obj.booleans.fit_selected && any([ obj.booleans.p_use_original obj.booleans.p_use_active]))
       
        f = f | strcmp('fit_btn',tags);
        
    end
    
    
    set(btns(f),'Enable','on');
    set(btns(not(f)),'Enable','off');  
    
end

end

