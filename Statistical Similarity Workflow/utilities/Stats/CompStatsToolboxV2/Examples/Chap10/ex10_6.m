% Example 10.6
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

load iris
% This loads up three matrices: 
% setosa, versicolor and virginica.
% We will use the versicolor and virginica.
% To make it interesting, we will use only the
% first two features.
% Get the data for the training and testing set. We
% will just pick every other one for the testing set.
indtrain = 1:2:50;
indtest = 2:2:50;
versitest = versicolor(indtest,1:2);
versitrain = versicolor(indtrain,1:2);
virgitest = virginica(indtest,1:2);
virgitrain = virginica(indtrain,1:2);

% Get the classifier. We will assume a multivariate
% normal model for these data. 
muver = mean(versitrain);
covver = cov(versitrain);
muvir = mean(virgitrain);
covvir = cov(virgitrain);

% Present each test case to the classifier. Note that
% we are using equal priors, so the decision is based
% only on the class-conditional probabilities.
% Put all of the test data into one matrix. 
X = [versitest;virgitest];
% These are the probability of x given versicolor.
pxgver=csevalnorm(X,muver,covver);
% These are the probability of x given virginica.
pxgvir=csevalnorm(X,muvir,covvir);
% Check which are correctly classified. 
% In the first 25, pxgver > pxgvir are correct.
ind = find(pxgver(1:25)>pxgvir(1:25));
ncc = length(ind);
% In the last 25, pxgvir > pxgver are correct.
ind = find(pxgvir(26:50) > pxgver(26:50));
ncc = ncc + length(ind);
pcc = ncc/50;

