function p = p0_to_p(p0,p,pf)
%P0_TO_P Replaces elements pf in p with elements in p0
%   
%   p = p0_to_p(p0,p,pf)
%
%   Parameters
%   p0          Parameter vector containing free parameters
%   p           Total parameter vector
%   pf          Vector specifying the indices where elements in p0 replace
%               the elements in p
%
%   Returns
%   p           Parameter vector where indices pf have been replaced with
%               elements of p0
%

p(pf) = p0;


end

