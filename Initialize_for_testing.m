% Copyright (c) 2015, Otto Virtanen
% All rights reserved.


dist = DST_Gaussian();
sm = SM_Hard_sphere(dist);

m = Model(sm);

c = Controller(m,'local');

v = c.view;