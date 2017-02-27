% Example 7.7
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Let's change the test statistic to xbar.
Tobs = mean(mcdata);
% Number of Monte Carlo trials.
M = 1000;				
% Start the simulation.
Tm = zeros(1,M);
for i = 1:M
			% Generate a random sample under H_0.
			xs = sigma*randn(1,n) + 454;
			Tm(i) = mean(xs);
end

% Get the p-value. This is an upper-tail test.
% Find all of the values from the simulation that are 
% below the observed value of the test statistic.
ind = find(Tm <= Tobs);
pvalhat = length(ind)/M;
