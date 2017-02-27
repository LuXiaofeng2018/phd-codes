% Example 8.1
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Loads the vectors x and y.
load steam	
% Fit a first degree polynomial to the data.
[p,s] = polyfit(x,y,1);

% We can evaluate the polynomial over a
% domain of interest.
xf = linspace(min(x),max(x));
yf = polyval(p,xf);

% Now produce the plot for figure 8.2
plot(x,y,'o',xf,yf,'-')
axis equal
xlabel('Average Temperature (\circ F)')
ylabel('Steam per Month (pounds)')