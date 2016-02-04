function p_table_export(obj,nodes)
%P_TABLE_EXPORT Collects all p vectors in Batch_loader nodes and writes it
%to a text file
%  
%   p_table_export()
%
% Parameters
% nodes         Data_nodes to be saved
%

% Copyright (c) 2016, Otto Virtanen
% All rights reserved.

if isempty(obj.model.bl.save_path)

    p_path = [pwd '/' datestr(now,30) '-FitIt-p-export.txt'];

else

    if strcmp(obj.model.bl.save_path(end),'/')
        p_path = [obj.model.bl.save_path datestr(now,30) '-FitIt-p-export.txt'];
    else
        p_path = [obj.model.bl.save_path '/' datestr(now,30) '-FitIt-p-export.txt'];
    end
end

% Create the p export file.

fid = fopen(p_path,'a');

if fid == -1

    h = msgbox('Could not open a file for exporting the p table. Check path and directory permissions.','Error');
    return;

else

    fclose(fid);

end


% Write parameter names to file

phv = obj.model.construct_p_header_vector(true);
phv = [{'"Filenames"'}; phv(:)];
fspec = ['%s' repmat(' %s',[1 numel(phv) - 1]) '\n'];

FileWriter.write_line(p_path,fspec,phv); % opens and closes automagically

for i = 1:numel(nodes)


   p_file = [nodes(i).total_param_vector(:)'; nodes(i).total_std_vector(:)'];
   p_file = num2cell(p_file(:));
   p_file = [strjoin(nodes(i).filenames,'+'); p_file];

   fspec = ['%s' repmat(' %.3e',[1 numel(p_file) - 1]) '\n'];

   FileWriter.write_line(p_path,fspec,p_file); % opens and closes automagically


end

end

