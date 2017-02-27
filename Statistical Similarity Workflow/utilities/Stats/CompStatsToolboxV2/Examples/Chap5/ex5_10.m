% Example 5.10
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Generate a sample from the uniform distribution.
xunif = rand(100,1);
% Generate sample from the standard normal.
xnorm = randn(100,1);
% Generate a sample from the exponential distribution.
% NOTE: this function is from the Statistics Toolbox.
xexp = exprnd(1,100,1);
boxplot([xunif,xnorm,xexp],'notch','on')
