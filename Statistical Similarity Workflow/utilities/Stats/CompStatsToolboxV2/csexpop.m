function y = csexpop(x,lambda)
% CSEXPOP Exponential probability density function.
%
%   Y = CSEXPOP(X,LAMBDA) Returns the values of the
%   exponential probability density function with
%   parameter LAMBDA, at the given values in X.
%
%   The exponential probability density function is 
%   given by f(x) = lambda*exp(-lambda*x).
%
%   See also CSEXPOC, CSEXPAR, CSEXPOQ, CSEXPRND, CSEXPOPLOT

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox 


if lambda <= 0
   error('Lambda must be greater than zero')
   return
end
y=zeros(size(x));
ind = find(x>=0);
arg = lambda*x(ind);
y(ind) = lambda*exp(-arg);
