close all;clc;clear
% run('EnviSetting');
%% ------------------------------------------------------------------------
% Compare hitogram with K-S test
load('.\P(xD_SD)\Summer_NND');
Summer = norm_NND;
load('.\P(xD_SD)\WCD_NND');
WCD = norm_NND;
load('.\P(xD_SD)\Borneo_NND');
Borneo = norm_NND;
load('.\P(xD_SD)\subWCD_NND');
subWCD = norm_NND;
load('.\P(xD_SD)\subSummer_NND');
subSummer = norm_NND;
% -------------------------------------------------------------------------
% 1. Summer - Borneo
[h,pvals1(1,1)] = kstest2(Summer(:,1),Borneo(:,1));
[h,pvals1(1,2)] = kstest2(Summer(:,2),Borneo(:,2));
[h,pvals1(1,3)] = kstest2(Summer(:,3),Borneo(:,3));
[h,pvals1(1,4)] = kstest2(Summer(:,4),Borneo(:,4));
% 2. WCD - Borneo
[h,pvals1(2,1)] = kstest2(WCD(:,1),Borneo(:,1));
[h,pvals1(2,2)] = kstest2(WCD(:,2),Borneo(:,2));
[h,pvals1(2,3)] = kstest2(WCD(:,3),Borneo(:,3));
[h,pvals1(2,4)] = kstest2(WCD(:,4),Borneo(:,4));
% 3. WCD - Summer
[h,pvals1(3,1)] = kstest2(WCD(:,1),Summer(:,1));
[h,pvals1(3,2)] = kstest2(WCD(:,2),Summer(:,2));
[h,pvals1(3,3)] = kstest2(WCD(:,3),Summer(:,3));
[h,pvals1(3,4)] = kstest2(WCD(:,4),Summer(:,4));
% % 4. subSummer - Summer
% [h,pvals(4,1)] = kstest2(subSummer(:,1),Summer(:,1));
% [h,pvals(4,2)] = kstest2(subSummer(:,2),Summer(:,2));
% [h,pvals(4,3)] = kstest2(subSummer(:,3),Summer(:,3));
% [h,pvals(4,4)] = kstest2(subSummer(:,4),Summer(:,4));
% % 5. subWCD - Summer
% [h,pvals(5,1)] = kstest2(subWCD(:,1),Summer(:,1));
% [h,pvals(5,2)] = kstest2(subWCD(:,2),Summer(:,2));
% [h,pvals(5,3)] = kstest2(subWCD(:,3),Summer(:,3));
% [h,pvals(5,4)] = kstest2(subWCD(:,4),Summer(:,4));
% % 6. subWCD - WCD
% [h,pvals(6,1)] = kstest2(subWCD(:,1),WCD(:,1));
% [h,pvals(6,2)] = kstest2(subWCD(:,2),WCD(:,2));
% [h,pvals(6,3)] = kstest2(subWCD(:,3),WCD(:,3));
% [h,pvals(6,4)] = kstest2(subWCD(:,4),WCD(:,4));
% % 7. subWCD - subSummer
% [h,pvals(7,1)] = kstest2(subWCD(:,1),subSummer(:,1));
% [h,pvals(7,2)] = kstest2(subWCD(:,2),subSummer(:,2));
% [h,pvals(7,3)] = kstest2(subWCD(:,3),subSummer(:,3));
% [h,pvals(7,4)] = kstest2(subWCD(:,4),subSummer(:,4));
% % 8. WCD - subSummer
% [h,pvals(8,1)] = kstest2(WCD(:,1),subSummer(:,1));
% [h,pvals(8,2)] = kstest2(WCD(:,2),subSummer(:,2));
% [h,pvals(8,3)] = kstest2(WCD(:,3),subSummer(:,3));
% [h,pvals(8,4)] = kstest2(WCD(:,4),subSummer(:,4));
%% ------------------------------------------------------------------------
% Compare hitogram with K-S test
load('.\P(xD)\Summer_NND');
Summer = norm_NND;
load('.\P(xD)\WCD_NND');
WCD = norm_NND;
load('.\P(xD)\Borneo_NND');
Borneo = norm_NND;
% -------------------------------------------------------------------------
% 1. Summer - Borneo
[h,pvals2(1,1)] = kstest2(Summer(:,1),Borneo(:,1));
[h,pvals2(1,2)] = kstest2(Summer(:,2),Borneo(:,2));
[h,pvals2(1,3)] = kstest2(Summer(:,3),Borneo(:,3));
[h,pvals2(1,4)] = kstest2(Summer(:,4),Borneo(:,4));
% 2. WCD - Borneo
[h,pvals2(2,1)] = kstest2(WCD(:,1),Borneo(:,1));
[h,pvals2(2,2)] = kstest2(WCD(:,2),Borneo(:,2));
[h,pvals2(2,3)] = kstest2(WCD(:,3),Borneo(:,3));
[h,pvals2(2,4)] = kstest2(WCD(:,4),Borneo(:,4));
% 3. WCD - Summer
[h,pvals2(3,1)] = kstest2(WCD(:,1),Summer(:,1));
[h,pvals2(3,2)] = kstest2(WCD(:,2),Summer(:,2));
[h,pvals2(3,3)] = kstest2(WCD(:,3),Summer(:,3));
[h,pvals2(3,4)] = kstest2(WCD(:,4),Summer(:,4));
