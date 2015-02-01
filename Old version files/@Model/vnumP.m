function p = vnumP(rc,w,pd,q)
%VNUMP Numerically evaluate the form factor of a spherical particle with arbitrary
%polarization density. (Vectorized)
%
% p = numP(rc,w,pd,q)
%
% Parameters
% 
% rc        Radial collocation points within the microgel
% w         quadrature weight
% pd        Polarization density at points rc
% q         Scattering vector magnitudes where form factor is evaluated
%
% Returns
% p         Form factor at points q
% -----------------------------------
% Scattering length is given by
%
% b(q) = 4pi integral_0^R dr r^2 pd(r) sin(qr)/qr
%
% Form factor by
% 
% p(q) = [b(q) / b(0)]^2;
%
% See Scattering Bible, Stieger, notes or whatever.
%

% Force to column vectors
pd = pd(:);
rc = rc(:);
q = q(:);

%w = mean(diff(rc));                            % quadrature weight, average rounding errors
qr = rc * q';                                   % form qr by matrix multiplication
pdr2w = (w .* pd .* rc.^2) * ones(size(q))';    % calculate dr * r^2 * pd(r) and extend to size(qr) 

% Integration
% Matlab 0/0 results in NaN. By definition sinc(0) = 1 so fix these
% entries.

b = 4 .*pi .* sum(pdr2w .* Model.rm_nan(sin(qr)./qr,qr==0),1)'; % Magic bullet!

% Apparently calling an external m file enables in place computation
% whereas nested version of rm_nan is about 30 - 40% slower. Summation down
% the columns gives also about 20% performance improvement (at least in 
% summation tests).

% Other approaches that are about 50% slower:
%qr = sin(qr)./qr;
%qr(isnan(qr)) = 1;
%b = 4 .*pi .* sum(pdr2w .* qr,2);

%b = 4 .*pi .* sum(pdr2w .* Model.snc(qr),2);

% Form factor
p = (b./(4 .*pi .* sum(pdr2w,1))').^2;

       
end

