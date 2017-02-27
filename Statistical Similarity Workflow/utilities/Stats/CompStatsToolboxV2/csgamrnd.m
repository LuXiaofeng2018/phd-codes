function X = csgamrnd(n,t,lam)
% CSGAMRND Generates gamma random variates.
%
%	X = CSGAMRND(N,T,LAMBDA) Returns a vector
% 	of N random variables from the gamma 
%	distribution with parameters T and LAMBDA.
%
%	NOTE: The parameter T must be an integer greater than 0.
%
%	The gamma probability density function is given
%	by 
%		{lambda*exp(-lambda*x)(lambda*x)^(t-1)}/Gamma(t)
%
%	See also CSGAMMP, CSGAMMC, CSGAMPAR


%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox 


% Check to make sure that t is an integer.
if floor(t)~=t | t <=0
    % then it is not an integer
    error('The parameter t must be a positive integer')
end


% generate the uniforms needed.
U = rand(t,n);
logU = -log(U)/lam;
if t ~= 1;
   X = sum(logU);
else
   X = logU;
end
