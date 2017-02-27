% Example 4.14
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Set the parameter for the Poisson
lam = .5;
N = 5000;			 % Sample size
x = cspoirnd(lam,N);
edges = 0:max(x);
f = histc(x,edges);
bar(edges,f/N,1,'w')
% Determine the observed relative frequencies.
% These are the estimated values.
relf = zeros(1,max(x)+1);
for i = 0:max(x)
   relf(i+1) = length(find(x==i))/N;
end
% Use the Statistics Toolbox function to get the 
% theoretical values.
y = poisspdf(0:4,.5);
