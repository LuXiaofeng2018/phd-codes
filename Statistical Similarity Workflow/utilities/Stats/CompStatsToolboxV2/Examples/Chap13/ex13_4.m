% Example 13.4
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

load salmon
% Get the predictor values and the response.
x = salmon(:,1);
y = salmon(:,2);
% Set up the target values.
x0 = linspace(min(x),max(x),20);
% Get the regular loess fit.
% This function is included in the
% Computational Statistics Toolbox.
alpha = 0.5;
lambda = 2;
yloess = csloess(x,y,x0,alpha,lambda);

% Get the robust loess fit.
yloessr = csloessr(x,y,x0,alpha,lambda);
% Now construct the scatterplot with smooth.
plot(x,y,'o',x0,yloess,x0,yloessr,':')
