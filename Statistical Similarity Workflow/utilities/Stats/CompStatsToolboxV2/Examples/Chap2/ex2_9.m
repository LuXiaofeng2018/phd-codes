% Example 2.9
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% First get the domain over which to evaluate
% the density function.
x=0.01:.01:.99;
% Now get the values for the density function.
y1=betapdf(x,0.5,0.5);
y2=betapdf(x,3,3);
% Plot the results.
plot(x,y1,'r',x,y2,'g')
title('Beta Distribution')
xlabel('x')
ylabel('f(x)')
