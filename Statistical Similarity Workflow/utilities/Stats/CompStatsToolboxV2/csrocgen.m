function [pcc,thresh]=csrocgen(x1,x2,k,pfa)
% CSROCGEN	Generate a Receiver Operating Characteristic (ROC) curve.
%
%	[PCC, THRESH] = CSROCGEN(X2,X2,K,PFA)
%
%	This function generates a ROC curve, where the multivariate normal
%	is used to model the class-conditional probabilities. This will
%	generate the probability of correctly classifying the target
%	class (X1), given the desired false alarm rates (PFA). It uses
%	K-fold cross-validation.
%
%	X1 is the data matrix for the target class. Each row is an observation.
%	X2 is the data matrix for the non-target class. Each row is an observation.
%	K is the number to leave out in the test set for cross-validation.
%	PFA is a vector of false alarm rates.

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox


% The algorithm is to:
%
% First find pfa: (thresh)
%  Take target data, build classifier
% For each non-target class, build LR
%  Do k-leave out, build classifer on remaining, eval
%  probab
% 
% Then find pcc:
%  Take all non-targets, build classifier
%  Loop over target data, leave k-out, build classifier
%    on remaining points
%  Eval probability of k points,
%  LR=p(x|target)/p(x|non-target)
%  order these, % above threshold are correctly classif
%
% class 1 is the target (x1), x2 is the non-target
% k is the number to leave out for cross-validation

[n1,p]=size(x1);
[n2,p]=size(x2);

if mod(n1,k) ~= 0 | mod(n2,k) ~= 0
	error('The sample sizes for each class must be n = r*k, for interger r.')
	break
end

lr1=zeros(1,n1);
lr2=zeros(1,n2);
pcc=zeros(size(pfa));

% first find the threshold corresponding to each false alarm rate
% build classifier using target data
mu1=mean(x1);
var1=cov(x1);

% Do cross-val on non-target class
for i=1:n2/k
  index=(1+(i-1)*k):k*i;
  data=x2(index,:);
  dataleft=x2;
  dataleft(index,:)=[];
  mu2=mean(dataleft);
  var2=cov(dataleft);
  lr2(index)=csevalnorm(data,mu1,var1)./csevalnorm(data,mu2,var2);
end
% sort the likehood ratios for the non-target class
lr2=sort(lr2);
% Get the thresholds
thresh=zeros(size(pfa));
for i=1:length(pfa)
	% CHANGE THIS TO GETTING THE SAMPLE QUANTILE!!!!
	npts=floor((1-pfa(i))*n2);
	thresh(i)=lr2(npts);
end
% Now find the probability of correctly classifying targets
mu2=mean(x2);
var2=cov(x2);
% Do cross-val on target class 0
for i=1:n1/k
  index=(1+(i-1)*k):k*i;
  data=x1(index,:);
  dataleft=x1;
  dataleft(index,:)=[];
  mu1=mean(dataleft);
  var1=cov(dataleft);
  lr1(index)=csevalnorm(data,mu1,var1)./csevalnorm(data,mu2,var2);  
end
% find the actual pcc
for i=1:length(pfa)
  pcc(i)=length(find(lr1 >= thresh(i)));
end
pcc = pcc/n1;
