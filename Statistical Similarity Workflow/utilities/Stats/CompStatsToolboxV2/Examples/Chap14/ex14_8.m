% Example 14.8
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Set up preliminaries.
load coal
% y contains number of disasters.
% year contains the year.
n = length(y);
m = 1100;						% number in chain
a1 = 0.5;
a2 = 0.5;
c1 = 0;
c2 = 0;
d1 = 1;
d2 = 1;
theta = zeros(1,m);
lambda = zeros(1,m);
k = zeros(1,n);
% Holds probabilities for k.
like = zeros(1,n);
% Get starting points.
k(1) = unidrnd(n,1,1);
% Note that k will indicate an index to the year
% that corresponds to a hypothesized change-point.
theta(1) = 1;
lambda(1) = 1;
b1 = 1;
b2 = 1;
% Start the Gibbs Sampler.
for i = 2:m
   kk = k(i-1);
   % Get parameters for generating theta
   t = a1 + sum(y(1:kk));
   lam = kk + b1;
   % Generate the variate for theta.
   theta(i) = gamrnd(t,1/lam,1,1);
   % Get parameters for generating lambda.
   t = a2 + sum(y) - sum(y(1:kk));
   lam = n-kk+b2;
   % Generate the variate for lambda.
   lambda(i) = gamrnd(t,1/lam,1,1);
   % Generate the parameters b1 and b2.
   b1 = gamrnd(a1+c1,1/(theta(i)+d1),1,1);
   b2 = gamrnd(a2+c2,1/(lambda(i)+d2),1,1);
   % Now get the probabilities for k.
   for j = 1:n
      like(j) = exp((lambda(i)-theta(i))*j)*(theta(i)/lambda(i))^sum(y(1:j));
   end
   like = like/sum(like);
   % Now sample the variate for k
   k(i) = cssample(1:n,like,1);
end
