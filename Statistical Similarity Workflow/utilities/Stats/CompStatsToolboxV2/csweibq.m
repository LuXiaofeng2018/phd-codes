function x = csweibq(prob,nu,a,b)
% CSWEIBQ Inverse Weibull cumulative distribution function.
%
%   X = CSWEIBW(PROB,NU,ALPHA,BETA) Returns the values of
%   the inverse cumulative distribution function for the
%   Weibull distribution with parameters NU, ALPHA, and BETA
%   at the values given in X. Note that these are the quantiles
%   of the Weibull.
%
%   See also CSWEIBP, CSWEIBC

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox 


if alpha <= 0 | beta <= 0
   error('Distribution parameters alpha and beta must be greater than zero')
   return
end

if ~isempty(find(prob<0 | prob >1))
   error('Probabilities must be between 0 and 1')
   return
end

x=zeros(size(prob));
x = a*(-log(1-prob)).^(1/b)+nu;