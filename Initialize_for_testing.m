dist = DST_Gaussian();
sm = SM_Hard_sphere(dist);

ds = Data_set();

m = Model(ds,sm);

c = Controller(m);

v = c.view;