% Example 5.5
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Generate the random variables.
m = 50;
x = randn(1,75);
y = randn(1,m);
% find the order statistics for y
ys = sort(y);
% Now find the associated quantiles using the x
p = ((1:m) - 0.5)/m;							% probabilities for quantiles
xs = csquantiles(x,p);
% Construct the plot
plot(xs,ys,'ko')
% Get the reference line.
% Use the 1st and 3rd quartiles of each set to
% get a line.
qy = csquantiles(y,[0.25,0.75]);
qx = csquantiles(x,[0.25,0.75]);
[pol, s] = polyfit(qx,qy,1);
% Add the line to the figure.
yhat = polyval(pol,xs);
hold on
plot(xs,yhat,'k')
xlabel('Sample Quantiles - X'),
ylabel('Sorted Y Values')
hold off
