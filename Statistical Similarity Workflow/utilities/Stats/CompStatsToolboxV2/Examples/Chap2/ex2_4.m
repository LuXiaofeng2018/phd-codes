% Example 2.4
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% First get the domain over which we will 
% evaluate the functions.
x = -1:.1:11;
% Now get the probability density function
% values at x.
pdf = unifpdf(x,0,10);
% Now get the cdf.
cdf = unifcdf(x,0,10);
% Do the plots.
subplot(1,2,1),plot(x,pdf)
title('Probability Density Function')
xlabel('X'),ylabel('f(X)')
axis([-1 11 0 0.2])
axis square
subplot(1,2,2),plot(x,cdf)
title('Cumulative Distribution Function')
xlabel('X'),ylabel('F(X)')
axis([-1 11 0 1.1])
axis square
