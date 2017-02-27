function y = cschip(x,n)
% CSCHIP Chi-square probability density function.
%
%   Y = CSCHIP(X,NU) Returns the value of the
%   chi-square probability density function with NU
%   degrees of freedom, at the given values in X.
% 
%   See also CSCHIC, CSCHIRND

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox 


if n <= 0
   error('The degrees of freedom must be greater than 0')
   return
end
y = gammp(x,n/2,0.5);