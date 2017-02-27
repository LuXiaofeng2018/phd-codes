function y = csweibc(x,nu,a,b)
% CSWEIBC Weibull cumulative distribution function.
%
%   Y = CSWEIBC(X,NU,ALPHA,BETA) Returns the values
%   of the cumulative distribution function for the
%   Weibull distribution with parameters NU, ALPHA,
%   and BETA at the values given in X.
%
%   See also CSWEIBP, CSWEIBQ


%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox 

if a <= 0 | b <= 0
   error('Distribution parameters alpha and beta must be greater than zero')
   return
end
y=zeros(size(x));
ind = find(x>nu);
arg=(x(ind)-nu)/a;
y(ind) = 1 - exp(-arg.^b);
