% Example 14.9
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Set up preliminaries.
sig = 5;
% We will generate 500 iterations of the chain.
n = 5000;
numchain = 4;
% Set up the vectors to store the samples.
% This is 4 chains, 5000 samples.
X = zeros(numchain,n);								
% This is 4 sequences (rows) of summaries.
nu = zeros(numchain,n);								
rhat = zeros(1,n);							% Track the rhat for each iteration.
% Get the starting values for the chain.
% Use over-dispersed starting points.
X(1,1) = -10;
X(2,1) = 10;
X(3,1) = -5;
X(4,1) = 5;
% Run the chain.
for j = 2:n				
    for i = 1:numchain
      % Generate variate from proposal distribution.
      y = randn(1)*sig + X(i,j-1);
      % Generate variate from uniform.
      u = rand(1);
      % Calculate alpha.
      alpha = normpdf(y,0,1)/normpdf(X(i,j-1),0,1);
      if u <= alpha
         % Then set the chain to the y.
         X(i,j) = y;
      else
         X(i,j) = X(i,j-1);
      end
   end
   % Get the scalar summary - means of each row.
   nu(:,j) = mean(X(:,1:j)')';
   rhat(j) = csgelrub(nu(:,1:j));
end
