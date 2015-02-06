function add_data_set_to_model(obj,d)
%ADD_DATASET Adds a dataset to the Model
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

switch numel(obj.model.data_sets)
    
    case 0
        
        error('Invalid Model.data_sets structure.');

    case 1 
        
        ds = obj.model.data_sets;
        
        if all(cellfun(@isempty, {ds.q_exp ds.i_exp ds.std_exp}))
            % only plotting Data_set present without experimental data
            
            ds.set_experimental_data(d);
            
        else % one complete data_set
            
           ds = Data_set(d(:,1),d(:,2),d(:,3));
    
           obj.model.add_data_set(ds); 
            
        end % if
        
    otherwise  % several Data_sets
        
        ds = Data_set(d(:,1),d(:,2),d(:,3));
    
        obj.model.add_data_set(ds);
        
end % switch

obj.view.add_g_source_for_data_set(ds);

end

