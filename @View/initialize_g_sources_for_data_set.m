function initialize_g_sources_for_data_set(obj,ds)
%ADD_G_SOURCE_FOR_DATA_SET Initializes a new Graphics_source instance for
%the last added Data_set instance
%   

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

si = findobj(obj.active_layout.axes_panel,'Tag','si_axes');

%% Graphics_source for plotting the model intensity

m = obj.model;
q = linspace(0.0001,max(ds.q_exp),200)';
ihandles = @() ds.active_handles;
intst = @()m.total_scattered_intensity(150,ihandles(),q);

gs = Graphics_source(si,'line',[0 0 0 0],q,intst);
obj.active_layout.add_g_source(gs);

%% Graphics_source for showing the experimental data

switch all(ds.std_exp == 1)
    
    case 1  % Artificial STD of 1 was added. Bad thing, bad!
        
        gs = Graphics_source(si,'scatter',[0 max(ds.q_exp) 0 0],@()ds.q_exp(),@()ds.i_exp(),@()ds.std_exp());
        
    case 0 % STD is there like it should be.
        
        gs = Graphics_source(si,'errorbar',[0 0 0 0],@()ds.q_exp(),@()ds.i_exp(),@()ds.std_exp());
        
end % switch

obj.active_layout.add_g_source(gs);

end

