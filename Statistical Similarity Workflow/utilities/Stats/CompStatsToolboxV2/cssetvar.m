function newvar = cssetvar(mus,pies,vars,x,nterms)
% CSSETVAR  Set new variance in adaptive mixtures density estimation.
%
%   NEWVAR = CSSETVAR(MUS,WGTS,VARS,X,NTERMS)
%   This function will set the variance for a new term in univariate
%   adaptive mixtures density estimation. NTERMS must be
%   the current number of terms and does not include the new term.

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox



f=exp(-.5*(x-mus(1:nterms)).^2./vars(1:nterms)).*pies(1:nterms);
f=f/sum(f);
f=f.*vars(1:nterms);
newvar=sum(f);

