function initialize_from_data(obj,data)
%INITIALIZE_FROM_DATA Remove existing experimental data and create new
%Data_sets from raw data.
% Cleans the data, initializes and adds the Data_sets, adjusts the number
% of parameters in scattering model and background and updates Model handles. 
%
%   initialize_from_data(data)
%
% Parameters
% data          Cell array containing [j x 3] double arrays, where columns
%               are q, intensity and std.
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

obj.remove_experimental_data();

data = std_chck(data);
data = rm_neg(data);


%% Initialize according to the number of datasets


for i = 1 : numel(data)
          
    ds = obj.data_to_data_set(data{i});
    obj.add_data_set(ds);
           
end


%% Adjust the number of paramters in the scattering models


for i = 1:numel(obj.s_models)
   
    sm = obj.s_models{i};
    sm.match_scale_factors_to_ds(numel(data));
    
end

obj.bg.match_scale_factors_to_ds(numel(data));

if not(isempty(obj.sls_br))
   
    obj.match_br_to_ds(numel(data));
    
end

%% Update handles

obj.update_handles();

end


function d = std_chck(d)
   % check whether STD is included and if not, add STD = 1

   dcols = cellfun(@(x)size(x,2), d);

   std_missing = dcols == 2;

   if any(std_missing)

       f = @(x) [x ones(size(x,1),1)];
       d = cellfun(f,d(std_missing),'UniformOutput',false);

   end

end

function d = rm_neg(d)
% removes negative intensity values from the data

for i = 1 : numel(d)
   
    di = d{i};
    
    q = di(:,1);
    intst = di(:,2);
    std = di(:,3);
    
    f = intst > 0;
    
    di = [q(f) intst(f) std(f)];
    d{i} = di;
    
    
end

end
