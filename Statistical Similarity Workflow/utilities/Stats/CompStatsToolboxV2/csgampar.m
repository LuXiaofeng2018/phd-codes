function [t,lam]=csgampar(x)
% CSGAMPAR Parameter estimation for the gamma distribution.
%
%	[T,LAMBDA] = CSGAMPAR(X) Returns estimates for the parameters
%	T and LAMBDA of the gamma distribution.
%
%	The gamma probability density function is given
%	by 
%		{lambda*exp(-lambda*x)(lambda*x)^(t-1)}/Gamma(t)
%
%	See also CSGAMMP, CSGAMMC, CSGAMRND


%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox 
% 	Reference: Statistical Theory, 4th Edition, by Bernard
%   Lindgren, page 273



n=length(x);
mu=mean(x);
m2=(1/n)*sum(x.^2);
t=mu^2/(m2-mu^2);
lam = mu/(m2-mu^2);