% Example 14.3
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Get the variances for the proposal distributions.
sig1 = 0.5;
sig2 = 0.1;
sig3 = 10;
% We will generate 500 iterations of the chain.
n = 500;
% Set up the vectors to store the samples.
X1 = zeros(1,n);
X2 = X1;
X3 = X1;
% Get the starting values for the chains.
X1(1) = -10;
X2(1) = 0;
X3(1) = 0;

% Run the first chain.
for i = 2:n
		% Generate variate from proposal distribution.
		y = randn(1)*sig1 + X1(i-1);
		% Generate variate from uniform.
		u = rand(1);
		% Calculate alpha.
		alpha = normpdf(y,0,1)/normpdf(X1(i-1),0,1);
		if u <= alpha
			% Then set the chain to the y.
			X1(i) = y;
		else
			X1(i) = X1(i-1);
		end
end
% Run second chain.
for i = 2:n
		% Generate variate from proposal distribution.
		y = randn(1)*sig2 + X2(i-1);
		% Generate variate from uniform.
		u = rand(1);
		% Calculate alpha.
		alpha = normpdf(y,0,1)/normpdf(X2(i-1),0,1);
		if u <= alpha
            			% Then set the chain to the y.
			X2(i) = y;
		else
			X2(i) = X2(i-1);
		end
end
% Run the third chain.
for i = 2:n
		% Generate variate from proposal distribution.
		y = randn(1)*sig3 + X3(i-1);
		% Generate variate from uniform.
		u = rand(1);
		% Calculate alpha.
		alpha = normpdf(y,0,1)/normpdf(X3(i-1),0,1);
		if u <= alpha
			% Then set the chain to the y.
			X3(i) = y;
		else
			X3(i) = X3(i-1);
		end
end

