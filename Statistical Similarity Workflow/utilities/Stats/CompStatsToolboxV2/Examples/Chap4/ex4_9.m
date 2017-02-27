% Example 4.9
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Let a = 3, b = 3
n=500;
a=3;
b=3;
rvs = betarnd(a,b,1,n);

% Now do the histogram.
[N,h]=hist(rvs,10);
% Change bar heights.
N=N/(h(2)-h(1))/n;
% Now get the theoretical probability density.
x = 0:.05:1;
y = betapdf(x,a,b);
plot(x,y)
axis equal
bar(h,N,1,'w')
hold on
plot(x,y,'k')
hold off
