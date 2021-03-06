function A = mult3(A,x)
%MULT3 Multiplies the third dimension of A elementwise with x 
%   Detailed explanation goes here

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

sA = size(A);
sx = size(x);

if all([numel(x) == 1 numel(sA) == 2])    % Scalar times matrix
    
    A = A .* x;
    return;

elseif any([numel(sA) < 3 min(sx) > 1 sA(3) ~= numel(x)]) % Vector times 3D matrix, check inputs
    
    error('Input arguments have wrong dimensions');
    
end

for i = 1:sA(3)
   
    %A(:,:,i) = bsxfun(@times,A(:,:,i),x(i));
    A(:,:,i) = A(:,:,i) .* x(i);
end


end

