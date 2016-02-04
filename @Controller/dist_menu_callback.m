function dist_menu_callback(obj,hObject,callbackdata)
%DIST_MENU_CALLBACK Callback for changing distribution through Distribution
%menu bar menu
%   

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

% for simplicity, remove all fit related data from nodes in Batch_loader
obj.model.bl.reset_nodes();

dh = Distribution.available_distributions(hObject.Label); % handle to distribution constructor
obj.swap_distribution(dh());

end

