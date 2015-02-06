function add_g_source_for_data_set(obj,ds)
%ADD_G_SOURCE_FOR_DATA_SET Initializes a new Graphics_source instance for
%the last added Data_set instance
%   

si = findobj(obj.active_layout.axes_panel,'Tag','si_axes');

gs = Graphics_source(si,'errorbar',[0 0 0 0],@()ds.q_exp(),@()ds.i_exp(),@()ds.std_exp());

obj.active_layout.add_g_source(gs);

end

