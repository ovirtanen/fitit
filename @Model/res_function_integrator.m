function i_mod = res_function_integrator(nc,p,handles,qs,r,dq)
%RES_FUNCTION_INTEGRATOR Function to integrate the scattering model
%experssion against q distribution due to instrumental smearing using the
%mid-point rule.
%
%   i_mod = res_function_integrator(nc,p,qs,r,dq)
%
% Parameters
% nc            Number of integration points for the PSD
% p             Total parameter vector
% handles       Cell array of function handles relevant to the dataset
% qs            Integration points for the smeared q [n x k double]
% r             Resolution function values for the integration points 
%               [n x k double]
% dq            Integration constants for nominal q values [1 x k double]
%
% Returns
% i_mod         Model intensity smeared due to resolution function
%
% qs = 
%
%   Nominal q values -->
%   q1      q2     ... qk     
%   _________________________
%  | q(1,1) q(2,1) ... q(k,1)
%  | q(1,2) q(2,2) ... q(k,2)
%  | q(1,3) q(2,3) ... q(k,3)
%  |   .      .          .       
%  |   .      .          .      
%  | q(1,n) q(2,n) ... q(6,n)
%
% r = 
%
%   q1      q2     ... qk     
%   _________________________
%  | r(1,1) r(2,1) ... r(k,1)
%  | r(1,2) r(2,2) ... r(k,2)
%  | r(1,3) r(2,3) ... r(k,3)
%  |   .      .          .       
%  |   .      .          .      
%  | r(1,n) r(2,n) ... r(6,n)
%
%
% dq =
%
%   dq(1,1) dq(2,1) ... dq(k,1)
%
% In the matrix qs each column denotes the k nominal q values from q1 to qk. 
% Rows in each column are the n integration points for the resolution
% function. Resolution function values for each n integration point for
% each nominal q value are in matrix r. Vector dq holds the integration
% constant for each nominal q value.

% Copyright (c) 2015,2016 Otto Virtanen
% All rights reserved.

i_mod = zeros(size(qs));

for i = 1:size(qs,1)
    
    for j = 1:numel(handles)
        
        intensity = handles{j}(nc,qs(i,:),p);
        % Force the orientation of the vector. Whether the intensity from
        % the handle is always a column vector, I'm not sure at this
        % instant.
        i_mod(i,:) = i_mod(i,:) + intensity(:)'; 
        
    end
    
end

i_mod = i_mod .* r;
i_mod = bsxfun(@times,i_mod,dq);
i_mod = sum(i_mod,1);

end

