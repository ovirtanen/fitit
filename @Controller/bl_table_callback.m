function bl_table_callback(obj,hObject,callbackdata,bl_view)
%BL_TABLE_CALLBACK Callback for cell selection in Batch_loader GUI aka
%unbelievable acrobatics because MATLAB sucks
%
% When the user selects multiple cells in the table rapidly, this callback 
% will be triggered every single time a new cell is added to the selection.
% Because we don't want to act every time this happens, Batch_loader_view
% also contains a timer, which this callback starts when selection is
% altered. Each call to this function also updates the last_t_indices in
% Batch_loader_view instance with the current cell selection indices.  If 
% no further additions are done, after 500 ms the timer StopFcn function 
% calls another "callback" in Controller, which checks the last selection
% indices and acts accordingly.
%
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

stop(bl_view.table_timer);
bl_view.set_last_t_indices(callbackdata.Indices);
start(bl_view.table_timer);

end

