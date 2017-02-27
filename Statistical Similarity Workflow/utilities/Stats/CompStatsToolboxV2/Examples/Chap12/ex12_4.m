% Example 12.4 - Logistic Regression
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez


% First load the data.
load wais
xall = wais(:,1);
yall = wais(:,2);
% Group the data according to the WAIS score.
x = unique(xall);
for i = 1:length(x)
    ind = find(x(i)== xall);
    y(i) = sum(yall(ind));
    n(i) = length(ind);
end

% We can use the multinomial fit with two
% groups to get our logistic regression fit.
[B,dev,stats] = mnrfit(x(:),[y(:), n(:)-y(:)]);

% Now find the the success probabilities for
% each WAIS score.
prop = y./n;
% Find the estimates of the success probability.
propfit = mnrval(B,x(:));

% Find fitted values for a range of x values and plot
% the curve with the observations.
xfit = linspace(min(x), max(x), 30);
propfitp = mnrval(B,xfit(:));
plot(x,prop,'.',xfit(:),propfitp(:,1));
axis([3 21 -.1 1.1])
xlabel('WAIS Score')
ylabel('Proportion')
title('Proportion with Symptoms of Senility')

% Plot the estimated probability at the mean
% as a special symbol.
pmeanfit = mnrval(B,mean(x));
hold on
plot(mean(x),pmeanfit(1),'o')
hold off

