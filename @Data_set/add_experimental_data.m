function add_experimental_data(obj,d)
%ADD_EXPERIMENTAL_DATA Adds experimental data to the Data_set if
%experimental variables are empty
% 
%   add_experimental_data(d)
%
%   Parameters
%
%   d           data array [q_exp i_exp std_exp]
%


[rows,cols] = size(d);

if not(all([cols == 3 rows >= 3]))
   
    error('Invalid data set structure.');
    
elseif not(all(cellfun(@isempty, {obj.q_exp obj.i_exp obj.std_exp})))
    
    error('Experimental data already loaded to this Data_set');
    
end % if

obj.q_exp = d(:,1);
obj.i_exp = d(:,2);
obj.std_exp = d(:,3);


end

