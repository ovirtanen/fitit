function update_table(obj)
%UPDATE_TABLE Updates the Batch_loader GUI data table

[d,ci] = Batch_loader.data_nodes_to_table(obj.view.model.bl.nodes);
obj.file_table.Data = d;
obj.file_table.RowName = ci;
drawnow();

end

