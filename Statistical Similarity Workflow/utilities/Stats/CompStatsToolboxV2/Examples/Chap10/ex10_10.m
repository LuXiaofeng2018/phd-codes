% Example 10.10
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Generate some observations that are
% bivariate normal. 
mu1 = [1;1];
mu2 = [-1;1];
sig1 = 2*eye(2);
sig2 = 2*eye(2);
% We will use equal class sizes,
% so the priors are 0.5.
data1 = mvnrnd(mu1,sig1,50);
data2 = mvnrnd(mu2,sig2,50);
X = [data1;data2];
clab = [ones(50,1);2*ones(50,1)];
