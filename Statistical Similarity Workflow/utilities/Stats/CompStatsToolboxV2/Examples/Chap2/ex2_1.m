% Example 2.1
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

prob = binocdf(3,25,0.2);
prob2 = sum(binopdf(0:3,25,0.2));
% Get the values for the domain, x.
x = 0:6;
% Get the values of the probability mass function
% First for n = 6, p = 0.3
pdf1 = binopdf(x,6,0.3);
% Now for n = 6, p = 0.7
pdf2 = binopdf(x,6,0.7);
% Do the plots.
subplot(1,2,1),bar(x,pdf1,1,'w')
title(' n = 6, p = 0.3')
xlabel('X'),ylabel('f(X)')
axis square
subplot(1,2,2),bar(x,pdf2,1,'w')
title(' n = 6, p = 0.7')
xlabel('X'),ylabel('f(X)')
axis square
