% Example 13.9
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Generate some x and y values.
x = linspace(0, 4 * pi,100);
y = sin(x) + 0.75*randn(size(x));
% Use loess to get the upper and lower smooths.
[yhat,ylo,xlo,yup,xup]=csloessenv(x,y,x,0.5,1,0);
% Plot the smooths and the data.
plot(x,y,'k.',x,yhat,'k',xlo,ylo,'k',xup,yup,'k')

