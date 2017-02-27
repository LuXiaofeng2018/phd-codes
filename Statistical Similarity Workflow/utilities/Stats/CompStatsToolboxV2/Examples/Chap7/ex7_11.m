% Example 7.11
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

load forearm
n = length(forearm);
alpha = 0.1;
B = 1000;
thetahat = mom(forearm);

% Get the bootstrap replicates and samples.
[bootreps, bootsam] = bootstrp(B,'mom',forearm);
% Set up some storage space for the SE’s.
sehats = zeros(size(bootreps));
% Each column of bootsam contains indices 
% to a bootstrap sample.
for i = 1:B
    		% extract the sample from the data 
				xstar = forearm(bootsam(:,i));
   bvals(i) = mom(xstar);
   % Do bootstrap using that sample to estimate SE.
   sehats(i) = std(bootstrp(25,'mom',xstar));
end
zvals = (bootreps - thetahat)./sehats;

% Estimate the SE using the bootstrap.
SE = std(bootreps);					

% Get the quantiles.
k = B*alpha/2;
szval = sort(zvals);
tlo = szval(k);
thi = szval(B-k);
% Get the endpoints of the interval.
blo = thetahat-thi*SE;
bhi = thetahat-tlo*SE;
