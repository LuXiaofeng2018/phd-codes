function beta3 = cskewness(x)
% CSKEWNESS Coefficient of skewness.
%
%   GAM = CSKEWNESS(X) Returns the sample coefficient
%   of skewness using the sample in X.
%
%   See also CSKURTOSIS

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox 



n=length(x);
mu=mean(x);
num = (1/n)*sum((x-mu).^3);
den = (1/n)*sum((x-mu).^2);

beta3 = num/den^(3/2);