function y = csbetap(x,a,b)
% CSBETAP Univariate beta probability density function.
%
%   Y = CSBETAP(X,ALPHA,BETA) Returns the value of the probability
%   density for the univariate beta distribution with
%   parameters ALPHA and BETA, at the values given in the
%   vector X.
%
%   See also CSBETAC, CSBETARND

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox


if a <= 0 | b <= 0
   error('Distribution parameters alpha and beta must be greater than zero')
   return
end
y = zeros(size(x));
cons = beta(a,b);
ind = find(x>=0 & x<=1);
y(ind) = x(ind).^(a-1).*(1-x(ind)).^(b-1);
y = y/cons;