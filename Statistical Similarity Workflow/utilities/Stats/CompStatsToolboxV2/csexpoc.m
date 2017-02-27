function y = csexpoc(x,lambda)
% CSEXPOC Exponential cumulative distribution function.
%
%   Y = CSEXPOC(X,LAMBDA) Returns the values of the
%   exponential cumulative distribution function with
%   parameter LAMBDA at the values contained in X.
%
%   The exponential probability density function is 
%   given by f(x) = lambda*exp(-lambda*x).
%
%   See also CSEXPOP, CSEXPAR, CSEXPOQ, CSEXPRND, CSEXPOPLOT

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox 


if lambda <= 0
   error('Lambda must be greater than zero')
   return
end
y=zeros(size(x));
ind = find(x>=0);
y(ind) = 1 - exp(-lambda*x(ind));
