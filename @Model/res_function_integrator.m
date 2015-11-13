function intst = res_function_integrator(nc,q_smeared,p,f)
%RES_FUNCTION_INTEGRATOR Function to integrate the scattering model
%experssion against q distribution due to instrumental smearing
%
%   intst = res_function_integrator(q_smeared,f)
%
% Parameters
% q_smeared     A 3D composite matrix with q values and integration
%               weights. See below for details
% p             Total paramter vector for the model
% f             Function handle to the model expression without smearing,
%               f(nc,q,p)
%
% Returns
% intst         Model intensity smeared due to resolution function
%
% q_smeared(:,:,1) = 
%
%   q(1,1) q(2,1) ... q(6,1) ... q(10,1) q(11,1)
%   q(1,2) q(2,2) ... q(6,2) ... q(10,2) q(11,2)
%   q(1,3) q(2,3) ... q(6,3) ... q(10,3) q(11,3)
%     .      .          .           .       .
%     .      .          .           .       .
%   q(1,n) q(2,n) ... q(6,n) ... q(10,n) q(11,n)
%
% q_smeared(:,:,2) = 
%
%   w(1,1) w(2,1) ... w(6,1) ... w(10,1) w(11,1)
%   w(1,2) w(2,2) ... q(6,2) ... w(10,2) w(11,2)
%   w(1,3) w(2,3) ... q(6,3) ... w(10,3) w(11,3)
%     .      .          .           .       .
%     .      .          .           .       .
%   w(1,n) w(2,n) ... w(6,n) ... w(10,n) w(11,n)
%
% Discretization to 11 points should be sufficient to express the
% instrumental smearing. Column 6 holds the nominal q values, row vectors
% q(i,:) hold the integration points of the q distribution. q_smeared(:,:,1)
% contains the q values, q_smeared(:,:,2) contains integration weights,
% i.e., QD(q_i,sigma_i) .* dq, where QD is the q distribution function with
% nominal q value q_i and STD sigma_i.
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

q = q_smeared(:,:,1);
w = q_smeared(:,:,2);

intst = zeros(size(q,1),1);

for i = 1:size(q,2)
    
    intst = intst + f(nc,q(:,i),p) .* w(:,i);  
    
end % for

end

