% Example 7.12
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Use Statistics Toolbox function
% to get the bootstrap replicates.
bvals = bootstrp(B,'mom',forearm);
% Find the upper and lower endpoints 
k = B*alpha/2;
sbval = sort(bvals);
blo = sbval(k);
bhi = sbval(B-k);
