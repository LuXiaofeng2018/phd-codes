% Example 10.14
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

load insect
% Let's keep out one observation from each
% class for testing purposes. 
Xtest = [insect([1,11,21],:)];
X = [insect([2:10,12:20,22:30],:)];
[n,d] = size(X);
% We also need group labels.
clabs = [ones(9,1);2*ones(9,1);3*ones(9,1)];

% Find 50 bootstrap replicates and classifiers.
B = 50;
boot = unidrnd(n,B,n);

% Classify the three test cases using
% each bootstrap sample.
results = zeros(3,B);
for i = 1:B
    % Get the indices to the boostrap sample.
    ind = boot(i,:);
    % Classify the test observations using the
    % classifier based on the bootstrap sample. 
    class = classify(Xtest,X(ind,:),clabs(ind),...
        'linear');
    % Store in the results array.
    results(:,i) = class(:);
end

% Find the majority class for the second test case.
ind1 = find(results(2,:)==1);
ind2 = find(results(2,:)==2);
length(ind1)
length(ind2)

