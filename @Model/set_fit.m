function set_fit(obj,p)
%SET_FIT Recalculates fit with parameters p
%   
% set_fit(p)
%
% Parameters
% p             Parameter vector with structure: 
%                  sd          Skin depth          p(1)
%                  pd          PD of core          p(2)
%                  epds        Excess pd of skin   p(3)
%                  fuzz        Fuzziness           p(4)
%                  amplitude   Amplitude           p(5)
%                  meanr       Mean of the PSD     p(6)
%                  pdist       Polydispersity      p(7)

[obj.fit,...,
 obj.rpd,...
 obj.rpsd,...
 obj.psd] = obj.scattered_intensity(obj.qfit,...
                                    p(4),...
                                    obj.nc,...
                                    p(1),...
                                    p(2),...
                                    p(3),...
                                    p(5),...
                                    p(6));


end

