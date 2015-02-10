dist = DST_Gaussian();
sm = SM_Hard_sphere(dist);

m = Model(sm);

c = Controller(m);

v = c.view;