function [piess,muss,varss]=csrup(x,pies,mus,vars,posterior,nterms,n)
% CSRUP     Recursive updates of finite mixture parameters.
%
%   [WGTS,MUS,VARS] = CSRUP(X,WGTS,MUS,VARS,POST,NTERMS,N)
%
%   This function recursively updates all of the parameters for
%   the adaptive mixtures density estimation approach. These are
%   the recursive update equations for the EM algorithm. 

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox


inertvar=10;
betan=1/(n);
piess=pies(1:nterms);
muss=mus(1:nterms);
varss=vars(1:nterms);
post=posterior(1:nterms);
% update the mixing coefficients
piess=piess+(post-piess)*betan;
% update the means
muss=muss+betan*post.*(x-muss)./piess;
% update the variances
denom=(1/betan)*piess+inertvar;
varss=varss+post.*((x-muss).^2-varss)./denom;


