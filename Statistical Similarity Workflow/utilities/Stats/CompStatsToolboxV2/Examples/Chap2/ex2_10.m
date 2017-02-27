% Example 2.10
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% First we get the domain for the function.
x = -6:.01:6;
% Now get the values for the density function.
y = tpdf(x,5);
% Plot the results.
plot(x,y)
title('Student''s t Distribution, \nu = 5')
xlabel('x')
ylabel('f(x)')
