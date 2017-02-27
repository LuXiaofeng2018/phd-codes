% Example 11.6
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% This will be an example of model-based
% agglomerative clustering. It uses a function
% provided with the Computational Statistics
% Toolbox. 

% First load the data.
load insect
% Again, we will look only at the first
% two dimensions in this example.
X = insect(:,1:2);
% Now call the model-based agglomerative
% clustering function.
z = agmbclust(X);

% We can plot in a dendrogram.
dendrogram(z);
title('Model-Based Agglomerative Clustering')

% Set to the same size as the other 
% dendrograms.
set(gcf,'pos',[9    95   800   500])


% We can get the cluster membership values.
cid = cluster(z,'maxclust',3);
% This is the same code as the previous example.
% We can also plot with different plotting symbols.
ind1 = find(cid == 1);
ind2 = find(cid == 2);
ind3 = find(cid == 3);
% Plot using different plotting symbols.
plot(X(ind1,1),X(ind1,2),'.')
hold on
plot(X(ind2,1),X(ind2,2),'+')
plot(X(ind3,1),X(ind3,2),'x')
hold off
xlabel('Width First Joint (microns)')
ylabel('Width Second Joint (microns)')
title('Three Clusters - Model-Based Agglomerative Clustering')
