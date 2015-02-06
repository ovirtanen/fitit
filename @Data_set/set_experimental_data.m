function set_experimental_data(obj,d)
%ADD_EXPERIMENTAL_DATA Sets experimental data to the Data_set.
% 
%   add_experimental_data(d) sets the experimental data q_exp, i_exp and
%   std_exp. If data has been loaded it will be replaced.
%
%   Parameters
%
%   d           data array [q_exp i_exp std_exp]
%


[rows,cols] = size(d);

if not(all([cols == 3 rows >= 3]))
   
    error('Invalid data set structure.');
    
end % if

obj.q_exp = d(:,1);
obj.i_exp = d(:,2);
obj.std_exp = d(:,3);

obj.q_mod = linspace(0,max(obj.q_exp),200)'; 


end

