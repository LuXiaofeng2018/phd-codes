function y = csnormc(x,mu,variance)
% CSNORMC Univariate normal cumulative distribution function.
%
%	Y = CSNORMC(X,MU,VAR) Returns the values of the normal cumulative
% 	distribution function with mean MU and variance VAR at the 
%	values given in X.
%
% 	See also CSNORMP, CSNORMQ, CSEVALNORM

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox 



if variance <= 0
   error('Variance must be greater than zero')
   return
end
% use the erf to get the cdf
arg = (x-mu)/sqrt(variance*2);
y = 0.5*erf(arg)+0.5;