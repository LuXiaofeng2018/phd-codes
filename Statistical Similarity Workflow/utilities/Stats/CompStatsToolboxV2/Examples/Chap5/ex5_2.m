% Example 5.2
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

load forearm
% Get parameter estimates for the normal distribution.
mu=mean(forearm);
v=var(forearm);
% Obtain normal pdf based on parameter estimates.
xp = linspace(min(forearm),max(forearm));
yp = csnormp(xp,mu,v);
% Get the information needed for a histogram.
[nu,x]=hist(forearm);
% Get the widths of the bins.
h = x(2)-x(1);
% Plot as density histogram - Equation 5.1.
bar(x,nu/(140*h),1)
hold on
plot(xp,yp)
title('Forearm Data Density Histogram and Estimate')
hold off
