% Example 14.6
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Set up preliminaries.
% Here we use k for the chain length, because n 
% is used for the number of trials in a binomial.
k = 1000;						% generate a chain of size 1000
m = 500; 						% burn-in will be 500
a = 2;					% chosen
b = 4;
x = zeros(1,k);
y = zeros(1,k);
n = 16;
% Pick a starting point.
x(1) = binornd(n,0.5,1,1);
y(1) = betarnd(x(1) + a, n - x(1) + b,1,1);
for i = 2:k
		x(i) = binornd(n,y(i-1),1,1);
		y(i) = betarnd(x(i)+a, n-x(i)+b, 1, 1);
end
% Get the marginal by evaluating the conditional.
% Use MATLAB's Statistics Toolbox.
% Find the P(X=x|Y's)
fhat = zeros(1,17);
for i = 1:17
		fhat(i) = mean(binopdf(i-1,n,y(500:k)));
end
