% Example 9.10
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez


% First create the model.
% The function expects a vector of weights;
% a matrix of means, where each column of the matrix
% corresponds to a d-D mean; a 3-D array of 
% covariances, where each page of the array is a
% covariance matrix.
pies = [0.5 0.3 0.2]; % mixing coefficients
mus=[-1 1 5; -1 1 6];
% Delete any previous variances in the workspace.
clear vars
vars(:,:,1)=eye(2); 
vars(:,:,2)=eye(2)*.5
vars(:,:,3)=[1 0.5; 0.5 1];
figure
csdfplot(mus,vars,pies)


mus(3,:)=[-1 1 2];
% Delete previous vars array or you will get an error.
clear vars
vars(:,:,1)=eye(3);
vars(:,:,2)=eye(3)*.5;
vars(:,:,3)=[1 0.7 0.2;
             0.7 1 0.5;
             0.2 0.5 1];
figure,csdfplot(mus,vars,pies)
% get a different viewpoint
view([-34,9])

