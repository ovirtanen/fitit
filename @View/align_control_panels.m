function align_control_panels(obj,p,h_spacer,top_spacer,v_spacer,varargin)
%ALIGN_CONTROL_PANELS Stacks Uipanels containing controls vertically to the
%GUI
%   
%   align_control_panels(h_spacer,top_spacer,v_spacer,p1,p2,...)
%
%   Parameters
%   p               Parent, the root Figure
%   h_spacer        Spacer from the left side of the root figure (px)
%   top_spacer      Spacer from the top of the root figure (px)
%   v_spacer        Spacer between the panels (px)
%   p1, p2,...      Uipanels to be aligned
%
%

f = @(x) isa(x,'matlab.ui.container.Panel');

if not(all(cellfun(f,varargin)))
   
    error('Wrong type of gui elements.');
    
end % if

h_pos = p.Position(4) - top_spacer - varargin{1}.Position(4);
obj.change_position(varargin{1},h_spacer,h_pos);

for i = 2:numel(varargin)
    
    h_pos = h_pos - v_spacer - varargin{i}.Position(4);
    obj.change_position(varargin{i},h_spacer,h_pos);
    
end % for


end

