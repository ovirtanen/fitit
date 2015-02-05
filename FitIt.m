function FitIt()
%FITIT Execute FitIt
% 

dist = DST_Gaussian();
sm = SM_Hard_sphere(dist);

ds = Data_set();

m = Model(ds,sm);

Controller(m);


end

