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

% adapt the fit range
obj.qfit = linspace(0,max(obj.q),200)';

p = obj.get_all_fit_param('fitting');
obj.set_fit(p); % sets obj.fit, obj.rpsd, obj.psd

notify(obj,'empirical_data_loaded');

end

