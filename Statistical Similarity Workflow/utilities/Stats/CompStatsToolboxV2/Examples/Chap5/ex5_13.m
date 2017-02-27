% Example 5.13
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez


% Create a bivariate standard normal
% First create a grid for the domain.
[x,y]=meshgrid(-3:.1:3,-3:.1:3);
% Evaluate using the bivariate standard normal.
z = (1/(2*pi))*exp(-0.5*(x.^2+y.^2));
% Do the plot as a surface.
surf(x,y,z)
axis tight
