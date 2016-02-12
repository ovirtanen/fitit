function j = total_jacobian(obj)
%TOTAL_JACOBIAN Calculates the Jacobian for all the datasets
%   
%   j = total_jacobian()
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.


ds = obj.data_sets;
p = obj.get_total_parameter_vector();
nc = obj.nc;
handles = obj.handles;

j = [];

for i = 1:numel(ds)
    
    q = ds(i).q_exp;
    ih = ds(i).active_handles;
    
    f = @(x,t) total_intensity(nc,handles,ih,x,t);
    
    ji = obj.estimate_jacobian(p,f,q);
    
    j = [j;ji];
    
end

end

function int = total_intensity(nc,h,ihandles,p,q)
% This is basically the same as Model.total_scattered_intensity

int = zeros(numel(q),1);

handles = h;

for i = ihandles

    int = int + handles{i}(nc,q,p);
    
end % for

end