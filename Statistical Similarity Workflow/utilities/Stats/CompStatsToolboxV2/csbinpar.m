function phat = csbinpar(x)
% CSBINPAR Estimate of success probability.
%
%   PHAT = CSBINPAR(X) Returns an estimate
%   of the success probability, given a vector
%   of values X that represent a success (1) or
%   a failure (0).
%
%   See also CSBINOP, CSBINOC, CSBINOQ, CSBINRND


%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox 


phat = mean(x);
