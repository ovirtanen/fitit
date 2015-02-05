function remove_exp_data(obj)
%REMOVE_EXP_DATA Removes all experimental data loaded to the Model
%
%   remove_exp_data()
%
%

if numel(obj.data_sets) ~= 1
% remove all but the 1st data_set

    obj.data_sets(2:end) = [];
    
end

obj.data_sets.remove_experimental_data();

end

