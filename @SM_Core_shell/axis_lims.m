function lims = axis_lims(obj)
%AXIS_LIMS Returns the axis limits for drawing the radial profile
%   
%
% Returns
% lims          [xmin xmax ymin ymax]
%
%

pdc = obj.get_param('pdc_val');
pds = obj.get_param('pds_val');

xmax = obj.dist.max_limit();
lims = [0 xmax 1.1 .* min([0 pdc pds]) 1.1 .* max([1 pdc pds])];

end

