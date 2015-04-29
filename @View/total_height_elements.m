function th = total_height_elements(v_spacer,varargin)
%TOTAL_HEIGHT OF ELEMENTS Calculates the total height of GUI elements
%   
%   th = total_height_elements(v_spacer,p1,p2,...) returns the total height 
%   of GUI elements calculated from the top of the first element to the 
%   bottom of the last element with v_spacer between each element.
%
%   Parameters
%   v_spacer        The spacer between the GUI elements, in the same units
%                   as the elements
%   p1, p2,...      Handles to the GUI elements
%
%   Returns
%   th              Total height in the same units as the elements p1,...

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

f = @(x) x.Units;

if numel(unique(cellfun(f,varargin,'UniformOutput',0))) ~= 1
    
    error('GUI elements do not have the same Units property.');
    
end % if

f = @(x) x.Position(4);

th = v_spacer .* (numel(varargin) - 1) + sum(cellfun(f,varargin));

end

