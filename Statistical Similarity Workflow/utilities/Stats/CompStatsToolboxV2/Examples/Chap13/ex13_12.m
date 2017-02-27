% Example 13.12
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% We add noise to the response variables, as follows:
y(1:50) = 2+sqrt(2)*randn(1,50);
y(51:100) = 3+sqrt(2)*randn(1,50);
y(101:150) = 10+sqrt(2)*randn(1,50);
y(151:200) = -10+sqrt(2)*randn(1,50);

% Fit the regression tree.
% Note that we do not have to use the method
% argument because the responses are
% continuous indicating it is regression.
tree = treefit(X,y(:));

% Now find the error using cross-validation.
[cost,secost,nt,best] = ...
    treetest(tree,'cross',X,y(:));

plot(nt,cost,nt(best+1),cost(best+1),'o')
xlabel('Number of Terminal Nodes')
ylabel('Cost')

treebest = treeprune(tree,'level',best)
