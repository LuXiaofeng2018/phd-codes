% Example 10.12
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Find the best tree from the previous example.
% First create an independent test sample.
n = 100;
u = rand(1,n);
% Find the number in class 1.
n1 = length(find(u<=0.5));
% The rest are in class 2.
n2 = n - n1;
% Generate the data for the classes.
testdata1 = mvnrnd(mu1,sig1,n1);
testdata2 = mvnrnd(mu2,sig2,n2);
% Put them into one matrix.
Xtest = [testdata1;testdata2];
% Get the class labels.
clabtest = [ones(n1,1);2*ones(n2,1)];

% Now find the error in the tree using 
% the independent test set. 
[erri,sei,nti,besti] = test(t,'test',Xtest,clabtest);

