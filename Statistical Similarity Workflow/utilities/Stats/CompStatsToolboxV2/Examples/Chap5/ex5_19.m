% Example 5.19
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Create a grid for the domain.
[x,y,z]=meshgrid(-3:.5:3,-3:.5:3,-3:.5:3);
[n,d]=size(x(:));
% Evaluate the trivariate standard normal.
a=(2*pi)^(3/2);
arg = (x.^2 + y.^2 + z.^2);
prob=exp((-.5)*arg)/a;
% Slice through the x=0, y=0, z=0 planes.
slice(x,y,z,prob,0,0,0)
xlabel('X Axis'),ylabel('Y Axis'),zlabel('Z Axis')

% Add a colorbar to indicate the value of the
% probability density function.
colorbar
