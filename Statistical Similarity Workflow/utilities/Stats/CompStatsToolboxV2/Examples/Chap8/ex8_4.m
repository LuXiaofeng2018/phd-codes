% Example 8.4
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Loads up a matrix - law.
load law
% Estimate the desired statistic from the sample.
lsat = law(:,1);
gpa = law(:,2);
tmp = corrcoef(gpa,lsat);
% Recall from Chapter 3 that the corrcoef function
% returns a matrix of correlation coefficients. We
% want the one in the off-diagonal position.
T = tmp(1,2);% Set up memory for jackknife replicates
n = length(gpa);
reps = zeros(1,n);
for i = 1:n
		% store as temporary vector
		gpat = gpa;
		lsatt = lsat;
		% leave i-th point out
		gpat(i) = [];
		lsatt(i) = [];
		% get correlation coefficient
		% In this example, is off-diagonal element
		tmp = corrcoef(gpat,lsatt);
		reps(i) = tmp(1,2);
end
mureps = mean(reps);
sehat = sqrt((n-1)/n*sum((reps-mureps).^2))
% Get the estimate of the bias
biashat = (n-1)*(mureps-T);
