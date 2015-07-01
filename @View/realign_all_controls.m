function realign_all_controls(obj)
%REALIGN_ALL_CONTROLS Resizes the GUI and realigns all the existing control
%panels and the fit button on the left side of GUI

panels = {obj.bg_panel obj.br_panel obj.p_panel obj.d_panel};
panels = panels(~cellfun(@isempty,panels));

g = obj.gui;

top_spacer = obj.spacers.top_spacer;
v_spacer = obj.spacers.v_spacer;
h_spacer = obj.spacers.h_spacer;
b_spacer = obj.spacers.bottom_spacer;

%% Resize root Figure if necessary -----------------------------------------

total_height = top_spacer + View.total_height_elements(v_spacer,obj.f_button,panels{:}) + b_spacer;

obj.resize_figure(g,b_spacer,total_height);   

%% Model controls alignment ------------------------------------------------

obj.align_control_panels(g,h_spacer,top_spacer,v_spacer,panels{:});

%% Fit button alignment ----------------------------------------------------

h_pos = obj.d_panel.Position(1) + obj.d_panel.Position(3) - obj.f_button.Position(3);
v_pos = obj.d_panel.Position(2) - v_spacer - obj.f_button.Position(4);
obj.change_position(obj.f_button,h_pos,v_pos);

for i = 1:numel(panels)
   
    panels{i}.Visible = 'on';
    
end

obj.f_button.Visible = 'on';

end

