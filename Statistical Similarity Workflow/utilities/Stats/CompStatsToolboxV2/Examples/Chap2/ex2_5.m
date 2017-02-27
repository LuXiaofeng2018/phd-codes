% Example 2.5
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Set up the parameters for the normal distribution.
mu = 5;
sigma = 2;
% Set up the upper and lower limits. These are in 
% the two element vector 'specs'.
specs = [2, 8];
prob = normspec(specs, mu, sigma);
