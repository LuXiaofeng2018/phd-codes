function X = csbinrnd(n,p,N)
% CSBINRND Returns a vector of binomial random variates.
%
%   X = CSBINRND(TRIALS,P,N) returns a vector of N random
%   variables from the binomial distribution with parameters
%   TRIALS and success probability P.
%
%   See also CSBINOP, CSBINOC, CSBINPAR, CSBINOQ   


%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox 


% Generate the uniform random numbers
% N variates of n trials
U = rand(n,N);
% Add up all of those less than or equal to
% the success probability.
X = sum(U<=p);


