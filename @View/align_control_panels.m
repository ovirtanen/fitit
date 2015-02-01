function align_control_panels(obj,h_spacer,top_spacer,v_spacer,varargin)
%ALIGN_CONTROL_PANELS Stacsk Uipanels containing controls vertically to the
%GUI
%   
%   align_control_panels(h_spacer,top_spacer,v_spacer,p1,p2,...)
%
%   Parameters
%   h_spacer        Spacer from the left side of the root figure (px)
%   top_spacer      Spacer from the top of the root figure (px)
%   v_spacer        Spacer between the panels (px)
%   p1, p2,...      Uipanels to be aligned
%
%

f = @(x) isa(x,'matlab.ui.container.Panel');

if all(cellfun(f,varargin))
   
    error('Wrong type of gui elements.');
    
end % if

f = @(x) x.Position(4);

% one v_spacer between every panel
total_height = v_spacer .* (numel(varargin) - 1) + sum(cellfun(f,varargin));

% check whether the panels fit to root figure
if total_height > obj.gui.Position(4)
   
    obj.resize_figure(total_height);
    
end % if

h_pos = top_spacer;
obj.change_position(varargin{1},h_spacer,h_pos);

for i = 2:numel(varargin)
    
    h_pos = h_pos + v_spacer;
    obj.change_position(varargin{i},h_spacer,h_pos);
    
end % for


end

