function set_empirical_data(obj,data)
%SET_EMPIRICAL_DATA Sets the empirical data
%
% set_empirical_data(data)
%
% Parameters
% data          Matrix containing the three columns [q intensity error]
%

obj.q = data(:,1);
obj.intensity = data(:,2);
obj.std = data(:,3);

notify(obj,'empirical_data_loaded');

end

