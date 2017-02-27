% Example 7.6
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Load up the data.
load mcdata
n = length(mcdata);  								
% Population sigma is known.
sigma = 7.8;					
sigxbar = sigma/sqrt(n);
% Get the observed value of the test statistic.
Tobs = (mean(mcdata)-454)/sigxbar;

% This command generates the normal probability plot.
% It is a function in the MATLAB Statistics Toolbox.
normplot(mcdata)

M = 1000;				% Number of Monte Carlo trials
	% Storage for test statistics from the MC trials.
	Tm = zeros(1,M);
	% Start the simulation.
for i = 1:M
			% Generate a random sample under H_0
			% where n is the sample size.
			xs = sigma*randn(1,n) + 454;
			Tm(i) = (mean(xs) - 454)/sigxbar;
end

% Get the critical value for alpha.
% This is a lower-tail test, so it is the
% alpha quantile.
alpha = 0.05;
cv = csquantiles(Tm,alpha);
