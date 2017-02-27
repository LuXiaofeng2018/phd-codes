function mr = csmoment(x,r)
% CSMOMENT r-th sample moment.
%
%   MR = CSMOMENT(X,R) Returns the R-th sample moment
%   using the sample given in X.
%
%   See also CSMOMENTC

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox 

n=length(x);
mu=mean(x);
mr = (1/n)*sum(x.^r);
