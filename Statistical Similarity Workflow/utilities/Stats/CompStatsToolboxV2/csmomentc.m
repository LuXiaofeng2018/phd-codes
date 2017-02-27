function mr = csmomentc(x,r)
% CSMOMENTC Sample r-th central moment.
%
%   MR = CSMOMENTC(X,R) Returns the sample R-th 
%   central moment for a given sample X.
%
%   See also CSMOMENT

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox 


n=length(x);
mu=mean(x);
mr = (1/n)*sum((x-mu).^r);
