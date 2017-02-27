% Example 8.2
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

load steam
% Get the set that will be used to 
% estimate the line.
indtest = 2:2:20; % Just pick some points.
xtest = x(indtest);
ytest = y(indtest);
% Now get the observations that will be
% used to fit the model.
xtrain = x;
ytrain = y;
% Remove the test observations.
xtrain(indtest) = [];
ytrain(indtest) = [];

% Fit a first degree polynomial (the model) to the data.
[p,s] = polyfit(xtrain,ytrain,1);

% Now get the predictions using the model and the
% testing data that was set aside.
yhat = polyval(p,xtest);
% The residuals are the difference between the true
% and the predicted values.
r = (ytest - yhat);

pe = mean(r.^2);