function post=csrpostup(x,pies,mus,vars,nterms)
% CSRPOSTUP Posterior probabilities.
%
%   POST = CSRPOSTUP(X,WGTS,MUS,VARS,NTERMS)
%   This function will return the posterior probabilities
%   for a univariate finite mixture.

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox

f=exp(-.5*(x-mus(1:nterms)).^2./...
   vars(1:nterms)).*pies(1:nterms);
f=f/sum(f);
post=f;

