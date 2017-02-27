function X = csdunrnd(N,n)
% CSDUNRND Generate random variables from the discrete uniform distribution.
%
%	R = CSDUNRND(N,NUMV) Returns a vector of NUMV random variables from the
%	discrete uniform distribution with parameter N. It picks numbers
%	uniformly between 1 and N.


%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox 


X = ceil(N*rand(1,n));