% Example 10.13
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

load iris
% Put into data matrix.
X = [setosa; versicolor; virginica];
% Create class labels.
clab = [ones(50,1);2*ones(50,1);3*ones(50,1)];
% Create the tree.
t = classregtree(X,clab,'splitmin',5,...
    'method','classification')

% First find the error in the tree using 
% the cross-validation method. 
% The default number of subsamples is ten.
[errCV,seCV,ntCV,bestCV]=test(t,'crossvalidate',...
    X,clab,...
    'nsamples',5);

% Now find the error in the tree using 
% the resubstitution method. 
[errR,seR,ntR,bestR] = test(t,'resubstitution');

