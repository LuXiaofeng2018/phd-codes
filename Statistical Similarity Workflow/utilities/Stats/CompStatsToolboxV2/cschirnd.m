function X = cschirnd(n,nu)
% CSCHIRND Chi-square random variates.
%
%   X = CSCHIRND(N,MU) Returns an array of N Chi-square
%   random variables with degrees of freedom NU.
%
%   See also CSCHISP, CSCHISC

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox 

% generate the uniforms needed depending on whether the 
rm = rem(nu,2);
k = floor(nu/2);
if rm == 0	% then even degrees of freedom
   U = rand(k,n);
   if k ~= 1
      X = -2*log(prod(U));
   else
      X = -2*log(U);
   end
else
   U = rand(k,n);
   Z = randn(1,n);
   if k ~= 1
      X = Z.^2-2*log(prod(U));
   else
      X = Z.^2-2*log(U);
   end
end

