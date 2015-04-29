function FitIt()
%FITIT Execute FitIt
% 

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

dist = DST_Gaussian();
sm = SM_Hard_sphere(dist);

m = Model(sm);

Controller(m,'local');


end

