function set_active_handles(obj,indices)
%SET_ACTIVE_HANDLES Sets the Data_set active_handles property
%   
%   set_active_handles(indices)
% 
% Parameters
% indices       The indices of the handles in Model.handles that are
%               necessary to calculate the total scattered intensity for
%               the data in this Data_set
%
%

Lib.inargtchck(indices, @(x) all([isfloat(x) x > 0 rem(x,1) == 0]));

obj.active_handles = indices;


end

