function [ y ] = trg( r,rbox,a,m)
%TRG Summary of this function goes here
%   Detailed explanation goes here

f = abs(r) <= rbox;

y = zeros(numel(r),1);

y(f) = (m-a)./rbox.*abs(r(f)) + a;

end

