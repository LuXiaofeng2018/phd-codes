% Example 11.10
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% This looks at the k-means function in the
% Statistics Toolbox, as well as the silhouette tools.

% NOTE: You will get different results from what was published in the 
% book because the following commands rely on random starts. 

load insect
% We will look only at the first
% two dimensions in this example.
X = insect(:,1:2);
% Get a k-means clustering using 3 clusters,
% and 5 trials or replicates. We also ask
% MATLAB to display the final results for
% each replicate. 
km3 = kmeans(X,3,'replicates',5,'display','final');

% Get k-means clusters using k = 5.
km5 = kmeans(X,5,'replicates',5,'display','final');

% Now get the silhouette values and plots.
[sil3,h3] = silhouette(X,km3);
title('K-Means Clustering of Insect Data')

figure
[sil5,h5] = silhouette(X,km5);
title('K-Means Clustering of Insect Data')


% Find the mean silhouette values for each
% grouping.
mean(sil3)
mean(sil5)

