% Example 8.5
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Here is another example. 
% We have 4 data sets with essentially the same
% correlation coefficient. 
% The scatterplots look very different.
% When this file is loaded, you get four sets
% of x and y variables.
load anscombe
% Do the scatterplots.
subplot(2,2,1),plot(x1,y1,'k*');
subplot(2,2,2),plot(x2,y2,'k*');
subplot(2,2,3),plot(x3,y3,'k*');
subplot(2,2,4),plot(x4,y4,'k*');
% Note that 'corr' is something we wrote.
[b1,se1,jv1] = csjack([x1,y1],'cscorr');
[b2,se2,jv2] = csjack([x2,y2],'cscorr');
[b3,se3,jv3] = csjack([x3,y3],'cscorr');
[b4,se4,jv4] = csjack([x4,y4],'cscorr');
