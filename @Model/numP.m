function p = numP(rc,pd,q)
%NUMP Numerically evaluate the form factor of a spherical particle with arbitrary
%polarization density
%
% p = numP(a,r,q)
%
% Parameters
% 
% rc        Radial collocation points within the microge
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

pd = pd(:);
rc = rc(:);
q = q(:);

w = mean(diff(rc));          % quadrature weight, average rounding errors

b = zeros(numel(q),1);

for i = 1:numel(q)

    b(i) = 4 .*pi .* sum(rc.^2 .* pd .* snc(q(i).* rc) .* w );
    
end % for

% p = [b(q) / b(0)]^2; sinc(0) = 1

p = (b./(4 .*pi .* sum(rc.^2 .* pd) .* w)).^2;  

    function s = snc(x)
    % SNC Unnormalized sinc function. Slight performance penalty. Consider
    % replacing if integration over distribution function / fitting gets
    % slow.
    
        if x < 1e-15; % zero within machine precision
            
            s = 1;
            
        else
            
            s = sin(x)./x;
            
        end
        
    end

end

