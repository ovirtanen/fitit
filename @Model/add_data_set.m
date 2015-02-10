function add_data_set(obj,ds)
%ADD_DATASET Adds a dataset to the Model
%  
%   add_data_set(ds)
%
%   Parameters
%   ds          
%
if isa(ds,'Data_set')
    
    obj.data_sets = [obj.data_sets ds];
    
else
   
    error('The parameter is not a Data_set.');
    
end


end



