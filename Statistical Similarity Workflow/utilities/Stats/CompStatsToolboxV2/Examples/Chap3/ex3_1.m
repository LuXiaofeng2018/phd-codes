% Example 3.1
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez


% generate a random sample from the uniform dist
n=2000;
x = rand(1,n);
% find the mean of the sample
mu=mean(x);

% find the numerator and denominator for beta3
num = (1/n)*sum((x-mu).^3);
den = (1/n)*sum((x-mu).^2);
gam1 = num/den^(3/2);

% find the kurtosis
num=(1/n)*sum((x-mu).^4);
den = (1/n)*sum((x-mu).^2);
gam2 = num/den^2;
