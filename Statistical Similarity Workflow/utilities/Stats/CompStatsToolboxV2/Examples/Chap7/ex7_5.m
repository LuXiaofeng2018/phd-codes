% Example 7.5
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

mu = 45;
sig = 15;
n = 100;
alpha = 0.05;
xbar = 47.2;

% Get the 95% confidence interval.
% Get the value for z_alpha/2
zlo = norminv(1-alpha/2,0,1);
zhi = norminv(alpha/2,0,1);
thetalo = xbar - zlo*sig/sqrt(n);
thetaup = xbar - zhi*sig/sqrt(n);
