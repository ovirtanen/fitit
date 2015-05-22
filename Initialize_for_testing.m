% Copyright (c) 2015, Otto Virtanen
% All rights reserved.


dist = DST_Gaussian();
dist.set_param_vector([500,30]);
sm = SM_Hard_sphere(dist);

m = Model(sm);

c = Controller(m,'local');

v = c.view;