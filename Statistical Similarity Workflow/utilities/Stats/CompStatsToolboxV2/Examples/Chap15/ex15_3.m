% Example 15.3
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

load okwhite
% Loads up two vectors: okwhx, okwhy
% These are event locations for the pattern.
% Get the convex hull.
K = convhull(okwhx, okwhy);
% K is the indices to points on the convex hull.
% Get the events.
cvh = [okwhx(K), okwhy(K)];
plot(okwhx,okwhy,'k.',cvh(:,1),cvh(:,2),'k')
title('Location of Thefts by Caucasian Offenders')
