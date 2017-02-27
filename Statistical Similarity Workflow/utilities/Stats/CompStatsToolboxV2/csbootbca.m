function [blo,bhi,bvals,z0,ahat] = csbootbca(data,fname,B,alpha)
% CSBOOTBCA 	Bootstrap BCA confidence interval
%	
%	[BLO,BHI,BVALS,ZO,AHAT] = CSBOOTBCA(X,FNAME,B,ALPHA)
%
%	This function calcualtes the bootstrap bias-corrected and
%	accelerated interval for a statistic given by FNAME. 
%	The outputs from this function are the lower and upper 
%	endpoints of the (1-ALPHA)*100% confidence interval.
%
%	X is an n x d array, where each row is an observation.
%	FNAME is a string for a MATLAB function that calculates a
%	statistic. The input argument to FNAME must be X only.
%	B is the number of bootstrap replicates. It is recommended that
%	this number be greater than 1000 for confidence intervals.
%	BLO and BHI are the endpoints of the interval.
%	BVALS is a vector of bootstrap replicates. 
%	Z0 and AHAT are used to verify the results.
%
%	See also CSBOOT, CSBOOTINT, CSBOOPERINT
%
%	Example: 	x = randn(50,1);
%				[blo,bhi,bvals,zo,ahat] = csbootbca(x,'mean',1000,0.05);
%				[blo,bhi,bvals,zo,ahat] = csbootbca(x,'myfun',1000,0.05);

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox

if alpha >= 0.5
	error('Alpha must be less than 0.5')
end
[n,d] = size(data);
if d > n
	error('Each row of the data array must correspond to an observation.')
end

thetahat=feval(fname,data);
[bh,se,bt]=csboot(data,fname,50);
[n,d] = size(data);
bvals = zeros(B,1);
% Loop over each resample and calculate the bootstrap replicates
for i = 1:B
   % generate the indices for the B bootstrap resamples, sampling with
   % replacement using the discrete uniform distribution.
   ind = ceil(n.*rand(n,1));
   % extract the sample from the data 
   % each row corresponds to a bootstrap resample
   xstar = data(ind,:);
   % use feval to evaluate the estimate for the i-th resample
   bvals(i) = feval(fname, xstar);
end
numless = length(find(bvals<thetahat));
z0 = norminv(numless/B,0,1);
% find the estimate for acceleration using jackknife
jvals = zeros(n,1);
for i = 1:n
   % use feval to evaluate the estimate with the i-th obervation removed
   % These are the jackknife replications.
   jvals(i) = feval(fname, [data(1:(i-1));data((i+1):n)]);
end
num = (mean(jvals)-jvals).^3;
den = (mean(jvals)-jvals).^2;
ahat = sum(num)/(6*sum(den)^(3/2));
zlo = norminv(alpha/2,0,1);  % this is the z^(a/2)
zup = norminv(1-alpha/2,0,1);  % this is the z^(1-a/2)
% Equation 14.10, E & T
arg = z0 + (z0 + zlo)/(1-ahat*(z0+zlo));
alpha1 = normcdf(arg,0,1);
arg = z0 + (z0 + zup)/(1-ahat*(z0+zup));
alpha2 = normcdf(arg,0,1);
k1 = floor(((B+1)*alpha1));
k2 = ceil(((B+1)*alpha2));  % ???
sbval = sort(bvals);
blo=sbval(k1);
bhi = sbval(k2);


