function y = cschic(x,n)
% CSCHIC Chi-square cumulative distribution function.
%
%   Y = CSCHIC(X,NU) Returns the value of the cumulative
%   distribution function for the chi-square distribution
%   with NU degrees of freedom, at a given vector of X values.
%
%   See also CSCHIP, CSCHIRND

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox 



if n <= 0
   error('The degrees of freedom must be greater than 0')
   return
end

y=zeros(size(x))
ind = find(x >=0);
y(ind) = gammainc(0.5*x(ind),n/2);