%% ------------------------------------------------------------------------
% This script test statistical similarity between lobe stacking patterns
% with the bootstrap L1-norm based two sample hypothesis test
% ------------------------------------------------------------------------
close all;clc;clear
run('EnviSetting');
nredraw = 1000;
% ------------------------------------------------------------------------
% load references
% Borneo
load('.\BorneoCoarse\Extracted\Borneo_NND');
% load('.\Borneo\Extracted\Borneo_NND');
B = NND;
dpxb = 0.04; % km/pixel
STDFactorb = 186.32;
% Amazon
load('.\Amazon\Extracted\Amazon_NND');
A = NND;
dpxa = 0.2609; % km/pixel
STDFactora = 169.02;
% SummerCoarse
SPath = '.\SummerCoarse\Extracted\ScalesNND\';
SList = dir(SPath);
SList(1:2)=[];
nfs = length(SList);
CFactorS =  57.8104; % factor in reachability plots
% WCDCoarse
WPath = '.\WCDCoarse\Extracted\ScalesNND\';
WList = dir(WPath); 
WList(1:2)=[];
nfw = length(WList);
CFactorW = 25.76; % factor in reachability plots


% ------------------------------------------------------------------------
% assigne spaces
% compare with Borneo
pSB = zeros(100,4);
pWB = zeros(100,4);
% compare with Amazon
pSA = zeros(100,4);
pWA = zeros(100,4);
% Boostrap compare with Borneo
pSBboot = zeros(100,4);
pWBboot = zeros(100,4);
% Bootrap compare with Amazon
pSAboot = zeros(100,4);
pWAboot = zeros(100,4);
% ------------------------------------------------------------------------
% Compare with Kolmogorov-Smirnov Test - matlab func:kstest2
% Summer
for i=1:nfs
    i
    sfname = SList(i).name;
    load([SPath sfname]);
    S = NND;
%     for j = 1:4
%         S(:,j)=S(:,j)/max(S(:,j));
%     end
    % compare with Borneo
    [h,pSB(i+1,1)]=kstest2(B(:,1),S(:,1));
    [h,pSB(i+1,2)]=kstest2(B(:,2),S(:,2));
    [h,pSB(i+1,3)]=kstest2(B(:,3),S(:,3));
    [h,pSB(i+1,4)]=kstest2(B(:,4),S(:,4));
    % compare with Amazon
    [h,pSA(i+1,1)]=kstest2(A(:,1),S(:,1));
    [h,pSA(i+1,2)]=kstest2(A(:,2),S(:,2));
    [h,pSA(i+1,3)]=kstest2(A(:,3),S(:,3));
    [h,pSA(i+1,4)]=kstest2(A(:,4),S(:,4));
    
    % bootrap compare with Borneo
    [L1Norm, pSBboot(i+1,1), L1NRedraws]=BootstrapTest2(B(:,1), S(:,1), nredraw);
    [L1Norm, pSBboot(i+1,2), L1NRedraws]=BootstrapTest2(B(:,2), S(:,2), nredraw);
    [L1Norm, pSBboot(i+1,3), L1NRedraws]=BootstrapTest2(B(:,3), S(:,3), nredraw);
    [L1Norm, pSBboot(i+1,4), L1NRedraws]=BootstrapTest2(B(:,4), S(:,4), nredraw);
    % bootstrap compare with Amazon
    [L1Norm, pSAboot(i+1,1), L1NRedraws]=BootstrapTest2(A(:,1), S(:,1), nredraw);
    [L1Norm, pSAboot(i+1,2), L1NRedraws]=BootstrapTest2(A(:,2), S(:,2), nredraw);
    [L1Norm, pSAboot(i+1,3), L1NRedraws]=BootstrapTest2(A(:,3), S(:,3), nredraw);
    [L1Norm, pSAboot(i+1,4), L1NRedraws]=BootstrapTest2(A(:,4), S(:,4), nredraw);
end
pSB(1,:)=pSB(2,:);
pSA(1,:)=pSA(2,:);
pSBboot(1,:)=pSBboot(2,:);
pSAboot(1,:)=pSAboot(2,:);
% WCD
for i=1:nfw
    
    wfname = WList(i).name;
    load([WPath wfname]);
    W = NND;
%     for j = 1:4
%         W(:,j)=W(:,j)/max(W(:,j));
%     end
    % compare with Borneo
    [h,pWB(i+1,1)]=kstest2(B(:,1),W(:,1));
    [h,pWB(i+1,2)]=kstest2(B(:,2),W(:,2));
    [h,pWB(i+1,3)]=kstest2(B(:,3),W(:,3));
    [h,pWB(i+1,4)]=kstest2(B(:,4),W(:,4));
    % compare with Amazon
    [h,pWA(i+1,1)]=kstest2(A(:,1),W(:,1));
    [h,pWA(i+1,2)]=kstest2(A(:,2),W(:,2));
    [h,pWA(i+1,3)]=kstest2(A(:,3),W(:,3));
    [h,pWA(i+1,4)]=kstest2(A(:,4),W(:,4));
    
    % bootstrap compare with Borneo
    [L1Norm,pWBboot(i+1,1), L1NRedraws]=BootstrapTest2(B(:,1),W(:,1), nredraw);
    [L1Norm,pWBboot(i+1,2), L1NRedraws]=BootstrapTest2(B(:,2),W(:,2), nredraw);
    [L1Norm,pWBboot(i+1,3), L1NRedraws]=BootstrapTest2(B(:,3),W(:,3), nredraw);
    [L1Norm,pWBboot(i+1,4), L1NRedraws]=BootstrapTest2(B(:,4),W(:,4), nredraw);
    % bootstrap compare with Amazon
    [L1Norm,pWAboot(i+1,1), L1NRedraws]=BootstrapTest2(A(:,1),W(:,1), nredraw);
    [L1Norm,pWAboot(i+1,2), L1NRedraws]=BootstrapTest2(A(:,2),W(:,2), nredraw);
    [L1Norm,pWAboot(i+1,3), L1NRedraws]=BootstrapTest2(A(:,3),W(:,3), nredraw);
    [L1Norm,pWAboot(i+1,4), L1NRedraws]=BootstrapTest2(A(:,4),W(:,4), nredraw);
end
pWB(1,:)=pWB(2,:);
pWA(1,:)=pWA(2,:);
pWBboot(1,:)=pWBboot(2,:);
pWAboot(1,:)=pWAboot(2,:);
% ------------------------------------------------------------------------
% plot out pvals
FieldName = {'Source Point Distance','Angle','Polygon Distance','Shape Similarity'};
% pvalues
X = [0:0.001:0.06];
XB = X*CFactorS*dpxb*STDFactorb;
XA = X*CFactorW*dpxa*STDFactora;
% hfb = figure;
% hfa = figure;
for i=1:4
    figure; % compare to Borneo
%     subplot(4,1,i);
    plot(XB,pSB(1:nfs+1,i),'-b',XB,pWB(1:nfw+1,i),'-r','linewidth',8);
    xlabel('Scale of interpretation (km)','FontSize',40);
    ylabel('Similarity','FontSize',40);
    set(gca,'FontSize',28);
    title(FieldName(i),'FontSize',28);
%     axis([0 80 0 1]);
    axis tight;
%     legend('Tank A vs. Indonesia','Tank B vs. Indonesia',...
%         'FontSize',16,'Location','NorthWest');
    figure; % compare to Amazon
%     subplot(4,1,i);
    plot(XA,pSA(1:nfs+1,i),'-.b',XA,pWA(1:nfw+1,i),'-.r','linewidth',8);
    xlabel('Scale of interpretation (km)','FontSize',40);
    ylabel('Similarity','FontSize',40);
    set(gca,'FontSize',28);
    title(FieldName(i),'FontSize',28);
    axis tight;
%     axis([0 235 0 1]);
%     legend(...
%            'Tank A vs. Amazon','Tank B vs. Amazon',...
%         'FontSize',16,'Location','NorthWest');
end

% hfb = figure;
% hfa = figure;
for i=1:4
    figure; % compare to Borneo
%     subplot(4,1,i);
    plot(XB,pSBboot(1:nfs+1,i),'-b',XB,pWBboot(1:nfw+1,i),'-r','linewidth',8);
    xlabel('Scale of interpretation (km)','FontSize',40);
    ylabel('Similarity','FontSize',40);
    set(gca,'FontSize',28);
    title(['Bootstrap ' FieldName(i)],'FontSize',28);
%     axis([0 80 0 1]);
    axis tight;
%     legend('Tank A vs. Indonesia','Tank B vs. Indonesia',...
%         'FontSize',16,'Location','NorthWest');
    figure; % compare to Amazon
%     subplot(4,1,i);
    plot(XA,pSAboot(1:nfs+1,i),'-.b',XA,pWAboot(1:nfw+1,i),'-.r','linewidth',8);
    xlabel('Scale of interpretation (km)','FontSize',40);
    ylabel('Similarity','FontSize',40);
    set(gca,'FontSize',28);
    title(['Bootstrap ' FieldName(i)],'FontSize',28);
    axis tight;
%     axis([0 235 0 1]);
%     legend(...
%            'Tank A vs. Amazon','Tank B vs. Amazon',...
%         'FontSize',16,'Location','NorthWest');
end
% % # clusters
% % subplot(5,1,5);
% figure;
% ClusterS = SOrder(:,2);
% ClusterW = WOrder(:,2);
% plot(YS,ClusterS(SIOrder),'-b',YW,ClusterW(WIOrder),'-r','linewidth',3)
% xlabel('Scale-of-interpretation','FontSize',20);
% ylabel('Number of clusters','FontSize',20);
% set(gca,'FontSize',20);
% title('# Clusters vs. Scale','FontSize',24);
% legend('Tank A vs. Indonesia','Tank B vs. Indonesia','FontSize',30);