function text_file_export(obj,nodes)
%TEXT_FILE_EXPORT Exports all the nodes in Batch_loader as text file
%
%   text_file_export()
%
% Parameters
% nodes         Data_nodes to be saved

% Copyright (c) 2016, Otto Virtanen
% All rights reserved.

ani = obj.model.bl.active_node_index;

if isempty(obj.model.bl.save_path)

    text_path = [pwd '/'];

else

    if strcmp(obj.model.bl.save_path(end),'/')
        text_path = obj.model.bl.save_path;
    else
        text_path = [obj.model.bl.save_path '/'];
    end

end


for i = 1 : numel(nodes)

    obj.model.initialize_from_data_node(nodes(i));

    path = [text_path datestr(now,30) '-' strjoin(nodes(i).filenames,'+') '-fit.txt'];

    obj.save_data(path);

end

% Get original data back if something was shown in the GUI
if not(isempty(ani))

    obj.model.bl.set_active_node(ani);
    obj.model.initialize_from_data_node(obj.model.bl.active_node);

end

end

