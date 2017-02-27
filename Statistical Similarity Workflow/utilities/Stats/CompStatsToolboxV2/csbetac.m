function y = csbetac(x,a,b)
% CSBETAC Univariate beta cumulative distribution function.
%
%   Y = CSBETAC(X,ALPHA,BETA) Returns the value of the
%   cumulative distribution function for the univariate
%   beta distribution with parameters ALPHA and BETA, at
%   the values given in vector X.
%
%   See also CSBETAP, CSBETARND

%   W. L. and A. R. Martinez, 5/22/00
%   Computational Statistics Handbook with MATLAB

if a <= 0 | b <= 0
   error('Distribution parameters alpha and beta must be greater than zero')
   return
end
y=zeros(size(x));
cons=beta(a,b);
ind=find(x>=0 & x<1);
y(ind) = betainc(x(ind),a,b);
y = y/cons;