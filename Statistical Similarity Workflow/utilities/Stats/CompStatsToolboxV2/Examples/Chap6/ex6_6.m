% Example 6.6
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Use the cereal data to illustrate
% the concept.

load cereal
[n,d] = size(cereal);
% Get the matrix of dissimilarities.
D = squareform(pdist(cereal,'cityblock'));
% Now implement the steps for classical MDS.
Q = -0.5*D.^2;
H = eye(n) - n^(-1)*ones(n,1)*ones(1,n);
B = H*Q*H;
[A,L] = eig(B);
[vals, inds] = sort(diag(L),'descend');
A = A(:,inds);
% Reduce the dimensionality to 2-D.
X = A(:,1:2)*diag(sqrt(vals(1:2)));
% Plot the points and label them.
plot(X(:,1),X(:,2),'o')
text(X(:,1),X(:,2),labs)
title('Classical MDS - City Block Metric')


