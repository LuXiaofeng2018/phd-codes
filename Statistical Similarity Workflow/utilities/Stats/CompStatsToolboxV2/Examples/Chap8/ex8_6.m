% Example 8.6
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Loads up a matrix.
load law
lsat = law(:,1);
gpa = law(:,2);
% Get the statistic from the original sample
tmp = corrcoef(gpa,lsat);
T = tmp(1,2);
% Set up memory for jackknife replicates
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
			tmp = corrcoef(gpat,lsatt);
			% In this example, is off-diagonal element.
		 	% Get the jackknife pseudo-value for the i-th point.
			reps(i) = n*T-(n-1)*tmp(1,2);
end
JT = mean(reps);
sehatpv = sqrt(1/(n*(n-1))*sum((reps - JT).^2));