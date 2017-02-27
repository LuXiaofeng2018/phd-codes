% Example 14.7
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Set up constants and arrays.
n = 6000;
xgibbs = zeros(n,2);							
rho = 0.9;
y = [1;2];				% This is the mean.
sig = sqrt(1-rho^2);								
% Initial point.
xgibbs(1,:) = [10 10];
% Start the chain.
for i = 2:n
   mu = y(1) + rho*(xgibbs(i-1,2)-y(2));
   xgibbs(i,1) = mu + sig*randn(1); 
   mu = y(2) + rho*(xgibbs(i,1) - y(1));
   xgibbs(i,2) = mu + sig*randn(1);
end

