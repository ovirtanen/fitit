function add_data_set_to_model(obj,d)
%ADD_DATASET Adds a dataset to the Model and creates appropriate
%Graphics_sources for it to the active layout
%  
%   add_data_set(ds)
%
%   Parameters
%   d          Data array with three columns [q_exp i_exp std_exp]
%

[rows,cols] = size(d);

if not(all([cols == 3 rows >= 3]))
   
    error('Invalid data set structure.');
    
end % id

ds = Data_set(d(:,1),d(:,2),d(:,3));
obj.model.add_data_set(ds);

end

