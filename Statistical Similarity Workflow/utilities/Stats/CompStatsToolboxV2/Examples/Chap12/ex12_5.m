% Example 12.5 - Generalized Linear Models
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Use the horseshoe crab data (Agresti, 2001 and Brockmann, 1996).

load crab
% The width of the female crab is in
% the first column of X.
plot(X(:,1),satellites,'.')
axis([20 34 -0.5 16])
xlabel('Carapace Width (cm)')
ylabel('Number of Satellites')

% Find the fit using a function from
% the MATLAB Statistics Toolbox.
beta = glmfit(X(:,1),satellites,'poisson');

% Use the glmval function in the Statistics
% Toolbox to find the estimated mean number of
% satellites for various values of x.
x0 = linspace(min(X(:,1)),max(X(:,1)),50);
yhat = glmval(beta,x0,'log');

% add the model to the plot.
hold on
plot(x0,yhat)
hold off

