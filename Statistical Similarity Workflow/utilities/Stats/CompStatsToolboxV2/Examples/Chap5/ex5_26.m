% Example 5.26
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Get a covariance matrix with correlation 1.
covmat = [1 1; 1 1];
% Generate the bivariate normal random variables .
[u,s,v] = svd(covmat);
vsqrt = (v*(u'.*sqrt(s)))';
subdata = randn(20,2);  
data = subdata*vsqrt;  
% Close any open figure windows.
close all
% Create parallel plot using CS Toolbox function. 
csparallel(data)
title('Correlation of 1')
