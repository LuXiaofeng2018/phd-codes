function mr = mom(x)
% MOM   Sample second central moment.
%
%   MR = MOM(X)
%   This function returns the sample second central moment.


%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox

n = length(x);
mu = mean(x);
mr = (1/n)*sum((x-mu).^2);
