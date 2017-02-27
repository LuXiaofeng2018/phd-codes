% Example 8.8
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% First load the data.
load spatial
% Now find the BC-a bootstrap interval
alpha = 0.10;	
B=2000;
% use the function we wrote to get the 
% 2nd sample central moment - 'mom'
[blo,bhi,bvals,z0,ahat] = ...
			csbootbca(spatial','mom',B,alpha);
        