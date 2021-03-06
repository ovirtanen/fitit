function fitoph = create_axes_for_l_curve_output(obj,shape)
%CREATE_AXES_FOR_L_CURVE_OUTPUT Creates subplot handles for plotting the
%solutions generated by the model.l_curve
%   
%   fitoph = create_axes_for_l_curve_output(shape)
%
% Parameters
% shape         Vector specifying the subplot shape: [nrows ncolumns] e.g. 
%               [2 2] for 2 x 2 subplot configuration
%
% Returns
% fitoph        Cellarray containing handles to the axis of each subplot
%
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

Lib.inargtchck(shape,@(x)numel(x) == 2, shape,@(x) x > 0, shape,@(x) all(mod(x,1) == 0));

k = 1:prod(shape);

fh = figure();

scale = shape(:)' ./ min(shape);
pos = fh.Position;
pos([3 4]) = pos([3 4]) .* fliplr(scale);
fh.Position = pos;

fitoph = arrayfun(@(x)subplot(shape(1),shape(2),x),k,'UniformOutput',0);

cellfun(@box,fitoph);
cellfun(@(x)Lib.assign(x,'Intensity (cm^{-1})','YLabel','String'),fitoph,'UniformOutput',0);
cellfun(@(x)Lib.assign(x,'log','YScale'),fitoph,'UniformOutput',0);
cellfun(@(x)Lib.assign(x,'q (nm^{-1})','XLabel','String'),fitoph,'UniformOutput',0);


end

