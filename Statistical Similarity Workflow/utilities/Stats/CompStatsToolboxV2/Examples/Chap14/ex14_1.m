% Example 14.1
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Generate 500 exponential random 
	% variables with lambda = 1.
% This is a Statistics Toolbox function.
x = exprnd(1,1,1000);								
% Take square root of each one.
xroot = sqrt(x);
% Take the mean - Equation 11.4
exroothat = mean(xroot);

% Now get it using numerical integration
strg = 'sqrt(x).*exp(-x)';
myfun = inline(strg);
% quadl is a MATLAB 6 function.
exroottru = quadl(myfun,0,50);
