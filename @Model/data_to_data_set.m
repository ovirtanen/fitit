function ds = data_to_data_set(d,qcf,ls)
%DATA_TO_DATA_SET Initialize Data_set from three-column double array
%   
%   ds = data_to_data_set(d)
%
% Parameters
% d             2-4 column double array, with columns q, intensity,
%               std and sigma parameters. Minimum q and intensity are
%               required
% qcf           Conversion factor to convert q (and sigma, if present) to
%               inverse nanometers
% ls            Line skip, how many data lines to skip when initializing
%               data_sets. 

% Copyright (c) 2015, 2016, Otto Virtanen
% All rights reserved.


[rows,cols] = size(d);

if rows < 3 || not(any([cols == 2 cols == 3 cols == 4]))
   
    error('Invalid data set structure.');
    
end % if

% Remove any bad points specific to this instrument
start_index = 1 + ls;
d = d(start_index:end,:);

% Remove negative intensity values
neq_filter = d(:,2) > 0;

if all(not(neq_filter))

    ME = MException('data_to_data_set:invalid_intensity', ...
                    'All intensity values are invalid (< 0)');
    throw(ME);
    
end

switch cols
    
    case 2
        
        q = d(:,1) .* qcf;
        intst = d(:,2);
        ds = Data_set(q(neq_filter),intst(neq_filter));
   
    case 3
        
        q = d(:,1) .* qcf;
        intst = d(:,2);
        intst_std = d(:,3);
        ds = Data_set(q(neq_filter),intst(neq_filter),intst_std(neq_filter));
        
    case 4
        
        q = d(:,1) .* qcf;
        intst = d(:,2);
        intst_std = d(:,3);
        sigma = d(:,4) .* qcf;
        ds = Data_set(q(neq_filter),intst(neq_filter),intst_std(neq_filter),sigma(neq_filter).^2);
        
    otherwise
        
        error('Invalid data set structure.');
        
end

end

