% Example 12.2
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez


load filip
% This loads up two vectors: x and y.
[p1,s]=polyfit(x,y,1);
% Get the curve from this fit.
yhat1 = polyval(p1,x);
plot(x,y,'k.',x,yhat1,'k')

[p10,s]=polyfit(x,y,10);
% Get the curve from this fit.
yhat10 = polyval(p10,x);
plot(x,y,'k.',x,yhat10,'k')
