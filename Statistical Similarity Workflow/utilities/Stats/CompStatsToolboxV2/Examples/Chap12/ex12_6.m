% Example 12.6 
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% This is the dose-response data from Dobson, page 119, Table 7.2.
% x = [1.6907, 1.7242, 1.7552, 1.7842, 1.8113, 1.8369, 1.861, 1.8839];
% n = [59 60 62 56 63 59 62 60];
% y = [6 13 18 28, 52, 53 61 60];

load beetle
% First plot the proportions.
plot(x,y./n,'.')
xlabel('Dose (log_10)')
ylabel('Proportion Killed')


[B1,dev1,stats1] = glmfit(x(:),[y(:) n(:)],'binomial');
[B2,dev2,stats2] = glmfit(x(:),[y(:) n(:)],'binomial','link','probit');
[B3,dev3,stats3] = glmfit(x(:),[y(:) n(:)],'binomial','link','comploglog');

% This is the logit model:
[B1, stats1.se]

fit1 = glmval(B1,x(:),'logit');
fit2 = glmval(B2,x(:),'probit');
fit3 = glmval(B3,x(:),'comploglog');

subplot(2,2,1),plot(fit1,y(:)./n(:),'.',[0 1],[0 1]);
title('Logit Link')
subplot(2,2,2),plot(fit2,y(:)./n(:),'.',[0 1],[0 1]);
title('Probit Link')
subplot(2,2,3),
hp = plot(fit3,y(:)./n(:),'.',[0 1],[0 1]);
title('Complementary Log-Log')

% Following adjusts the spacing for the plot.
ha = get(hp,'parent');
hax = ha{1};
pos = get(hax,'pos');
pos(1) = 0.35;
set(hax,'pos',pos)

% Note - maybe get rid of the vertical axis stuff except for 0 and 1. Then
% put on the labels for x and y axes. 

figure
subplot(2,2,1),plot(fit1,stats.residd,'.',[0 1],[0 0]);
title('Logit Link')
subplot(2,2,2),plot(fit2,stats2.residd,'.',[0 1],[0 0]);
title('Probit Link')
subplot(2,2,3),
hp = plot(fit3,stats3.residd,'.',[0 1],[0 0]);
title('Complementary Log-Log')
axis([0 1 -2 2])

% Following adjusts the spacing for the plot.
ha = get(hp,'parent');
hax = ha{1};
pos = get(hax,'pos');
pos(1) = 0.35;
set(hax,'pos',pos)
