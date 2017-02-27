% Example 6.2
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% This is to illustrate PCA. 
% Use the glass data set from UCI Repository. 

load glassdata
[n,d] = size(glassdata);
% Center the data.
Xc = glassdata - repmat(sum(glassdata)/n,n,1);
% Find the covariance matrix.
covm = cov(Xc);

% We could explore the data graphically using the following
% functions from the Statistics Toolbox.
gplotmatrix(glassdata,glassdata,classlab)
andrewsplot(glassdata,'group',classlab,'standardize','pca')
parallelcoords(glassdata,'group',classlab,'standardize','pca')

[v,d]= eig(covm);
% get the eigenvalues and make sure they
% are in ascending order. 
% Also get the indexes of the sort, 
% to re-order the columns of the 
% eigenvector matrix. 
[eigvals,inds] = sort(diag(d),'descend');
% Create the scree plot
plot(1:9, eigvals ,'ko-')
title('Scree Plot - Glass Data')
xlabel('Index')
ylabel('Eigenvalue')

% Looks like one should keep k = 3 dimensions.

% Now calculate the cumulative percentage of variance.
pervar = 100*cumsum(eigvals)/sum(eigvals);

% Show the first 5 here: 
% 47.6205   73.9398   84.7198   94.9223   98.2290  

% Based on this, we would keep the first 4 to explain 
% approximately 95% of the variance.

% Explore the transformed data using projections.
eigvecs = v(:,inds);
P3 = eigvecs(:,1:3);
Xp3 = Xc*P3;
gplotmatrix(Xp3,glassdata,classlab)

% This code will project using the first 4 eigenvectors.
P4 = eigvecs(:,1:4);
Xp4 = Xc*P4;


