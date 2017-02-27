% Example 8.3
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Set up the array to store the prediction errors.
n = length(x);
r1 = zeros(1,n);						% store error - linear fit
r2 = zeros(1,n);						% store error - quadratic fit
r3 = zeros(1,n);
% Loop through all of the data. Remove one point at a
% time as the test point.
for i = 1:n
   xtest = x(i);						% Get the test point.
   ytest = y(i);
   xtrain = x;						% Get the points to build model.
   ytrain = y;
   xtrain(i)=[];						% Remove test point.
   ytrain(i)=[];
   % Fit a first degree polynomial to the data.
   [p1,s] = polyfit(xtrain,ytrain,1);
   % Fit a quadratic to the data.
   [p2,s] = polyfit(xtrain,ytrain,2);
   % Fit a cubic to the data
   [p3,s] = polyfit(xtrain,ytrain,3);
   % Get the errors
   r1(i) = (ytest - polyval(p1,xtest)).^2;
   r2(i) = (ytest - polyval(p2,xtest)).^2;
   r3(i) = (ytest - polyval(p3,xtest)).^2;
end
% Get the prediction error for each one.
pe1 = mean(r1);
pe2 = mean(r2);
pe3 = mean(r3);
