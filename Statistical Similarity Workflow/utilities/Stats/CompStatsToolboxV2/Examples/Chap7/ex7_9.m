% Example 7.9
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

load forearm
% sample with replacement from this.
% first get the sample size.
n = length(forearm);
B = 100;			% number of bootstrap replicates
% Get the value of the statistic of interest.
theta = skewness(forearm);

% Use unidrnd to get the indices to the resamples.
% Note that each column corresponds to indices
% for a bootstrap resample.
inds = unidrnd(n,n,B);
% Extract these from the data.
xboot = forearm(inds);
% We can get the skewness for each column using
% MATLAB Statistics Toolbox function skewness.
thetab = skewness(xboot);
seb = std(thetab);

% Now show how to do it with MATLAB Statistics Toolbox
% function: bootstrp
Bmat = bootstrp(B,'skewness',forearm);
% What we get back are the bootstrap replicates.
% Get an estimate of the standard error.
sebmat = std(Bmat);
