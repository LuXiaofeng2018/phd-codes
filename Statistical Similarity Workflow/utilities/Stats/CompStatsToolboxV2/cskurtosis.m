function beta4 = cskurtosis(x)
% CSKURTOSIS Coefficient of kurtosis.
%
%   GAM = CSKURTOSIS(X) Returns the sample coefficient of
%   kurtosis using the sample in X. The kurtosis should
%   be approximately 3 for a normal distribution.
%
%   See also CSKEWNESS

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox 



n=length(x);
mu=mean(x);

num=(1/n)*sum((x-mu).^4);
den = (1/n)*sum((x-mu).^2);

beta4 = num/den^2;