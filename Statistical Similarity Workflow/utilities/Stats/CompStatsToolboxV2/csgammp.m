function y = csgammp(x,t,lambda)
% CSGAMMP Gamma probability density function.
%
%	Y = CSGAMMP(X,T,LAMBDA) returns the value of
%	the gamma probability density function at the
%	values given in X. The parameters of the gamma
%	distribution are T and LAMBDA.
%
%	The gamma probability density function is given
%	by 
%		{lambda*exp(-lambda*x)(lambda*x)^(t-1)}/Gamma(t)
%
%	See also CSGAMMC, CSGAMPAR, CSGAMRND


%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox 



if t <= 0 | lambda <= 0
   error('Distribution parameters must be greater than zero')
   return
end
y=zeros(size(x));
ind = find(x >= 0);  % pdf defined for these values
y(ind) = lambda*exp(-lambda*x(ind)).*(lambda*x(ind)).^(t-1);
cons = 1/gamma(t);
y = cons*y;