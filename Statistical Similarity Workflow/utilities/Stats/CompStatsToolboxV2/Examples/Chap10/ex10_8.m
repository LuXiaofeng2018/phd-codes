% Example 10.8
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Generate some data, use the model in Example 10.3.
% p(x|w1) ~ N(-1,1), p(w1) = 0.6
% p(x|w2) ~ N(1,1),p(w2) = 0.4;
% Generate the random variables.
n = 1000;
u = rand(1,n);					% find out what class they are from
n1 = length(find(u <= 0.6));	% # in target class
n2 = n-n1;
x1 = randn(1,n1) - 1;
x2 = randn(1,n2) + 1;

% Set up some arrays to store things.
lr1=zeros(1,n1);
lr2=zeros(1,n2);
pfa = 0.01:.01:0.99;
pcc=zeros(size(pfa));

% First find the threshold corresponding 
% to each false alarm rate.
% Build classifier using target data.
mu1=mean(x1);
var1=cov(x1);
% Do cross-validation on non-target class.
for i=1:n2
			train = x2;
			test = x2(i);
			train(i) = [];
			mu2=mean(train);
			var2=cov(train);
			lr2(i)=csevalnorm(test,mu1,var1)./...
					csevalnorm(test,mu2,var2);
end
% sort the likehood ratios for the non-target class
lr2=sort(lr2);
% Get the thresholds
thresh=zeros(size(pfa));
for i=1:length(pfa)
			thresh(i) = csquantiles(lr2,1-pfa(i));
end

% Now find the probability of correctly 
% classifying targets.
mu2=mean(x2);
var2=cov(x2);
% Do cross-validation on target class.
for i=1:n1
			train = x1;
			test = x1(i);
			train(i) = [];
			mu1=mean(train);
			var1=cov(train);
			lr1(i)=csevalnorm(test,mu1,var1)./...
				csevalnorm(test,mu2,var2);  
end
% Find the actual pcc.
for i=1:length(pfa)
  			pcc(i)=length(find(lr1 >= thresh(i)));
end
pcc = pcc/n1;

area = sum(pcc)*.01;
