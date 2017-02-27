% Example 4.1
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Obtain a vector of uniform random variables in (0,1).
x = rand(1,1000);
% Do a histogram to plot. 
% First get the height of the bars.
[N,X]=hist(x,15);
% Use the bar function to plot.
bar(X,N,1,'w')
title('HISTOGRAM OF UNIFORM RANDOM VARIABLES')
xlabel('X')
ylabel('FREQUENCY')
% generate 3 random samples of size 5.
x=zeros(3,5);   % allocate the memory
for i=1:3
   		rand('state',i) % set the state
   x(i,:)=rand(1,5);
end

% Generate 3 random samples of size 5.
x = zeros(3,5);   % Allocate the memory.
for i = 1:3
   		rand('state',i) % set the state
   x(i,:) = rand(1,5);
end

% Recover previous state.
rand('state',2)
xt = rand(1,5);
