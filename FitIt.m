function FitIt()
%FITIT Execute FitIt
% 

dist = DST_Gaussian();
sm = SM_Hard_sphere(dist);

m = Model(sm);

Controller(m,'local');


end

