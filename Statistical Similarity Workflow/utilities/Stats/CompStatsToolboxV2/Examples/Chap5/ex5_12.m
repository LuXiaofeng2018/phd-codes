% Example 5.12
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Create a positive definite covariance matrix.
vmat=[2, 1.5; 1.5, 9];
% Create mean at (2,3).
mu=[2 3]; 
[u,s,v]=svd(vmat);
vsqrt=(v*(u'.*sqrt(s)))';
% Get standard normal random variables.
td=randn(250,2); 
% Use x=z*sigma+mu to transform - see Chapter 4.
data=td*vsqrt+ones(250,1)*mu; 

% Create a scatter plot using the plot function.
% Figure 5.17.
plot(data(:,1),data(:,2),'x')
axis equal

% Create a scatter plot using the scatter. 
% Figure 5.18.
% Use filled-in markers.
scatter(data(:,1),data(:,2),'filled')
axis equal
box on
