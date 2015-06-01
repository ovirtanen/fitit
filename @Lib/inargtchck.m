function inargtchck(varargin)
%INARGTCHCK Checks types of the input arguments by passing the inargs to 
%the user specified function handle that returns a boolean
%   
% inargtchck(inarg1,h1,inarg2,h2,...)
%
% Parameters
% inarg         Input argument
% h             Handle to a function that accepts inarg and returns 1 or 0
%
%
% Simple checks can be done with built in is* functions (see Matlab
% documentation). More elaborate checks can be constructed with custom
% function handles, e.g., check that matrix is 2 x 3:
% @(x) all([numel(x(:,1)) == 2 numel(x(1,:)) == 3]);
%
% Examples:
% inargtchck(1, @isfloat, [2 3], @isvector)
% inargtchck(1, @isfloat, [2 3; 4 5], @isvector)
%   > Error using inargtchck (line 36)
%   > Input argument 2 did not pass the input argument check.
% inargtchck(1, @isfloat, [2 3 4; 5 6 7], @(x) all([numel(x(:,1)) == 2 numel(x(1,:)) == 3]))

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

if numel(varargin) < 2 || mod(numel(varargin),2) ~= 0
    
    error('Minimum input for inargtchck 1 inarg and 1 handle.');
    
end

b = argchck(varargin);

switch all(b)
   
    case 1
        
        return;
        
    otherwise
        
        inds = find(not(b));
        error('Input argument %d did not pass the input argument check.\n',inds);
    
end

end

function b = argchck(argin)
% helper function for inargtchck

switch numel(argin)
    
    case 2
        
        b = argin{2}(argin{1});
        
    otherwise

        b = [argin{2}(argin{1}) argchck(argin(3:end))];
    
end

end