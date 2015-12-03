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


% No data, all except Import Data and Set Path disabled
if(isempty(obj.view.model.bl.nodes))
   
    f = strcmp('import_data_btn',tags) | strcmp('set_path_btn',tags);
    
    set(btns(f),'Enable','on');
    set(btns(not(f)),'Enable','off');
    
    return;
    
end

end

