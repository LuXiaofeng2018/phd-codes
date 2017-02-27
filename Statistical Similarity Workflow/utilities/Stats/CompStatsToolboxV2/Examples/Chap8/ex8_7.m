% Example 8.7
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

x=[58, 67, 74, 74, 80, 89, 95, 97, 98, 107];
% Set up memory for jackknife replicates.
n = length(x);
reps = zeros(1,n);
for i = 1:n
			% Store as temporary vector.
			xt = x;
			% Leave i-th point out.
			xt(i) = [];
			% Get the median.
			reps(i) = median(xt);
end
mureps = mean(reps);
sehat = sqrt((n-1)/n*sum((reps-mureps).^2));
% Now get the estimate of standard error using
% the bootstrap.
[bhat,seboot,bvals]=csboot(x','median',500);


