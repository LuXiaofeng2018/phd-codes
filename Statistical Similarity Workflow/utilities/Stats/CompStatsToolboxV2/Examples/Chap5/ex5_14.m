% Example 5.14
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Get the data for plotting.
[x,y,z]=peaks;

% Create a 2-D contour plot with labels.
% This returns the information for labels.
c = contour(x,y,z); 
% Add the labels to the plot.
clabel(c)

% Create a 2-D filled contour plot.
contourf(x,y,z,15)

% Create a 3-D contour plot.
contour3(x,y,z,15)
