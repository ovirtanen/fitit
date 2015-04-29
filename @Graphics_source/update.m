function update(obj)
%UPDATE Updates the contents of graphics objects
%   

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

h = obj.g_handle;

% update data -------------------------------------------------------------

l = cellfun(@isempty, {obj.xy obj.x obj.y obj.e});
            
if all([0 1 1 1] == l)    % xy
                
    [xx,yy] = obj.xy();
    
    h.XData = xx;
    h.YData = yy;
                
elseif all([1 0 0 1] == l)% x,y
                
    h.XData = obj.x();
    h.YData = obj.y();
                
elseif all([1 0 0 0] == l) && not(isa(h,'matlab.graphics.chart.primitive.ErrorBar')) % x,y,e; eclude e
                  
    % error is included in the data, but we don't want to plot it
    h.XData = obj.x();
    h.YData = obj.y();
    
elseif all([1 0 0 0] == l)  % x,y,e
                  
    h.XData = obj.x();
    h.YData = obj.y();
    h.LData = obj.e();
    h.UData = obj.e();
                
else
                
    error('Initialization error.');
                
end % if

% update limits -----------------------------------------------------------

lims = obj.axis_lims();
            
l = lims == 0;
            
if all(l)
                
    obj.target_axis.XLimMode = 'auto';
    obj.target_axis.YLimMode = 'auto';
                
elseif all(l(1:2))
                
    obj.target_axis.XLimMode = 'auto';
    obj.target_axis.YLim = lims(3:end);
                
elseif all(l(3:end))
                
    obj.target_axis.XLim = lims(1:2);
    obj.target_axis.YLimMode = 'auto';
                
else
                
    obj.target_axis.XLim = lims(1:2);
    obj.target_axis.YLim = lims(3:end);
                
end % if

end

