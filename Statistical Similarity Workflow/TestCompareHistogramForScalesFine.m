close all;clc;clear
run('EnviSetting');
%% ------------------------------------------------------------------------
% Compare hitogram with K-S test - xD|SD
% Borneo
load('.\P(xD_SD)\Borneo_NND');
B = norm_NND;
% Summer
load('.\P(xD_SD)\Summer_NND');
S = norm_NND;
% WCD
load('.\P(xD_SD)\WCD_NND');
W = norm_NND;
% ------------------------------------------------------------------------
% assigne spaces
pS = zeros(100,4);
pW = zeros(100,4);
% ------------------------------------------------------------------------
% Compare the finest scale
% Summer
[h,pS(1,1)]=kstest2(B(:,1),S(:,1));
[h,pS(1,2)]=kstest2(B(:,2),S(:,2));
[h,pS(1,3)]=kstest2(B(:,3),S(:,3));
[h,pS(1,4)]=kstest2(B(:,4),S(:,4));

% WCD
[h,pW(1,1)]=kstest2(B(:,1),W(:,1));
[h,pW(1,2)]=kstest2(B(:,2),W(:,2));
[h,pW(1,3)]=kstest2(B(:,3),W(:,3));
[h,pW(1,4)]=kstest2(B(:,4),W(:,4));
% ------------------------------------------------------------------------
% Compare other scales
% summers
SPath = 'D:\workspace\TempWork\NewData\InfoExtract\SummerScales\NND\';
SList = dir(SPath);
SList(1:2)=[];
nf = length(SList);
SOrder = zeros(nf,2);
for i=1:nf
    name = SList(i).name;
    % scales of the file list
    SOrder(i,1) = str2num(name(end-30:end-30+4));
    % # clusters of the file list
    SOrder(i,2) = str2num(name(1:end-41));
end
% sort by scales
[YS,SIOrder]=sort(SOrder(:,1));
% compare by scales
for i=1:nf
    fname = SList(SIOrder(i)).name;
    load(fname);
    D = norm_NND;
    % compare
    [h,pS(i+1,1)]=kstest2(B(:,1),D(:,1));
    [h,pS(i+1,2)]=kstest2(B(:,2),D(:,2));
    [h,pS(i+1,3)]=kstest2(B(:,3),D(:,3));
    [h,pS(i+1,4)]=kstest2(B(:,4),D(:,4));
end
% ------------------------------------------------------------------------
% Compare other scales
% WCD
WPath = 'D:\workspace\TempWork\NewData\InfoExtract\WCDScales\NND\';
WList = dir(WPath);
WList(1:2)=[];
nf = length(WList);
WOrder = zeros(nf,2);
for i=1:nf
    name = WList(i).name;
    % scales of the file list
    WOrder(i,1) = str2num(name(end-27:end-27+4));
    % # clusters of the file list
    WOrder(i,2) = str2num(name(1:end-38));
end
% sort by scales
[YW,WIOrder]=sort(WOrder(:,1));
% compare by scales
for i=1:nf
    fname = SList(WIOrder(i)).name;
    load(fname);
    D = norm_NND;
    % compare
    [h,pW(i+1,1)]=kstest2(B(:,1),D(:,1));
    [h,pW(i+1,2)]=kstest2(B(:,2),D(:,2));
    [h,pW(i+1,3)]=kstest2(B(:,3),D(:,3));
    [h,pW(i+1,4)]=kstest2(B(:,4),D(:,4));
end
% ------------------------------------------------------------------------
% Compare other scales
% plot out pvals
FieldName = {'Source Point','Orientation','Polygon Proximity','Shape Similarity'};
% pvalues
figure;
for i=1:4
    subplot(4,1,i);
%     figure;
    plot(YS,pS(1:nf,i),'-b',YW,pW(1:nf,i),'-r','linewidth',3)
    xlabel('Scale-of-interpretation','FontSize',20);
    ylabel('p_values','FontSize',16);
    set(gca,'FontSize',16);
    title(FieldName(i),'FontSize',24);
    legend('Tank A vs. Indonesia','Tank B vs. Indonesia','FontSize',16,'Location','NorthWest');
end
% # clusters
% subplot(5,1,5);
figure;
ClusterS = SOrder(:,2);
ClusterW = WOrder(:,2);
plot(YS,ClusterS(SIOrder),'-b',YW,ClusterW(WIOrder),'-r','linewidth',3)
xlabel('Scale-of-interpretation','FontSize',20);
ylabel('Number of clusters','FontSize',20);
set(gca,'FontSize',20);
title('# Clusters vs. Scale','FontSize',24);
legend('Tank A vs. Indonesia','Tank B vs. Indonesia','FontSize',30);