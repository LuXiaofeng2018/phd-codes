function y = csgammc(x,t,lambda)
% CSGAMMC Gamma cumulative distribution.
%
%	Y = CSGAMMC(X,T,LAMBDA) Returns the value of the
% 	gamma cumulative distribution function at the
% 	values given in X. The parameters of the gamma
%	distribution are T and LAMBDA.
%
%	The gamma probability density function is given
%	by 
%		{lambda*exp(-lambda*x)(lambda*x)^(t-1)}/Gamma(t)
%
%	See also CSGAMMP, CSGAMPAR, CSGAMRND


%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox 



if t <= 0 | lambda <= 0
   error('Distribution parameters must be greater than zero')
   return
end

y=zeros(size(x));
ind=find(x>=0);
y(ind) = gammainc(lambda*x(ind),t);

