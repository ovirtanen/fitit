function initialize_g_sources_for_data_set(obj,ds)
%ADD_G_SOURCE_FOR_DATA_SET Initializes a new Graphics_source instance for
%the last added Data_set instance
%   

si = findobj(obj.active_layout.axes_panel,'Tag','si_axes');

% Graphics_source for plotting the model intensity
q = linspace(0.0001,max(ds.q_exp),200)';
intst = @()obj.model.total_scattered_intensity(150,q);
gs = Graphics_source(si,'line',[0 0 0 0],q,intst);
obj.active_layout.add_g_source(gs);

% Graphics_source for showing the experimental data
gs = Graphics_source(si,'errorbar',[0 0 0 0],@()ds.q_exp(),@()ds.i_exp(),@()ds.std_exp());
obj.active_layout.add_g_source(gs);

end

