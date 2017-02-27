close all;clc;clear
addpath(genpath('D:\Dropbox\utilities\'));
% ------------------------------------------------------------------------
% load data
DataName = 'Borneo';
load(DataName);
%% ------------------------------------------------------------------------
% Examples of orientation
fT = figure;

Theta1 = T(5,:); % E - center lobe
Edge1 = cell2mat(Edges(5,:));
v1 = Theta1(3:4)-Theta1(1:2);
v1 = [v1 0];

Theta2 = T(11,:); % K
Edge2 = cell2mat(Edges(11,:));
v2 = Theta2(3:4)-Theta2(1:2);
v2 = [v2 0];

plot(Edge1(:,2),Edge1(:,1),'r-',Edge2(:,2),Edge2(:,1),'b-'...
    ,'LineWidth',2);
hold on;
plot(Theta1(1),Theta1(2),'MarkerSize',30);
quiver(Theta1(1),Theta1(2),v1(1),v1(2),'r','LineWidth',5);
quiver(Theta2(1),Theta2(2),v2(1),v2(2),'b','LineWidth',5);
hold off;
set(gca,'YDir','reverse');
% axis off;
% ------------------------------------------------------------------------
% compute the angle
theta12 = abs(VecAng(v1,v2));
title(sprintf('theta12=%f',theta12));
%% ------------------------------------------------------------------------
% Examples of source distances
fD = figure;
SP1 = SP(5,:); % E - center lobe
SP2 = SP(11,:); % K
sd = sqrt(sum((SP1-SP2).^2));

plot(Edge1(:,2),Edge1(:,1),'r-',Edge2(:,2),Edge2(:,1),'b-'...
    ,'LineWidth',2);
hold on;
plot(SP1(1),SP1(2),'.r',SP2(1),SP2(2),'.b','MarkerSize',50);
hold off;
set(gca,'YDir','reverse');
title(sprintf('source distance =%f',sd));
% axis off;
%% ------------------------------------------------------------------------
% hausdorff ditance for polygon proximity
[hd12 D12] = HausdorffDist(Edge1,Edge2);
% find point that the distances are taken
% 1 vs. 2
[i,j]=find(D12==hd12);
p121 = Edge1(i(ceil(length(i/2))),:);p122 = Edge2(j(ceil(length(i/2))),:);
Line12X = [p121(2); p122(2)];
Line12Y = [p121(1); p122(1)];

fP = figure;
plot(Edge1(:,2),Edge1(:,1),'r-',Edge2(:,2),Edge2(:,1),'b-'...
    ,'LineWidth',2);
hold on;
plot(Line12X,Line12Y,'-g',...
     'LineWidth',5);
hold off;
set(gca,'YDir','reverse');
title(sprintf('hd12=%f',hd12));
%% ------------------------------------------------------------------------
% hausdorff ditance for shape
% eleminate translation, scale and orientation difference
% unit horizontal vector
uv = [0 1 0];
% 1
% source and centroid
cx1 = Theta1(1);cy1 = Theta1(2);
ccx1 = mean(Edge1(:,2));ccy1 = mean(Edge1(:,1));
Theta1(3)=ccx1;Theta1(4)=ccy1;
% % source and orientation
% cx1 = Theta1(1);cy1 = Theta1(2);

s1 = sqrt(mean((Edge1(:,2)-cx1).^2+(Edge1(:,1)-cy1).^2));
NTheta1(1:2:3) = (Theta1(1:2:3)-cx1)/s1;
NTheta1(2:2:4) = (Theta1(2:2:4)-cy1)/s1;
nv1 = NTheta1(3:4)-NTheta1(1:2);
nv1 = nv1./norm(nv1);
nv1 = [nv1 0];
Edge1 = fliplr(Edge1);
NEdge1(:,1)= (Edge1(:,1)-cx1)/s1;NEdge1(:,2)= (Edge1(:,2)-cy1)/s1;
dtheta1 = VecAng(uv,v1);
NNTheta1 = [NTheta1(1:2) 0;NTheta1(3:4) 0];
r1 = vrrotvec(nv1, uv);
R1 = vrrotvec2mat(r1);
NNTheta1 = (R1*NNTheta1')';
nnv1 = NNTheta1(2,:)-NNTheta1(1,:);
NEdge1 = [NEdge1 zeros(size(NEdge1,1),1)];
NEdge1 = (R1*NEdge1')'; NEdge1 = NEdge1(:,1:2);NEdge1 = fliplr(NEdge1);
Edge1 = fliplr(Edge1);
%2
% source and centroid
cx2 = Theta2(1);cy2 = Theta2(2);
ccx2 = mean(Edge2(:,2));ccy2 = mean(Edge2(:,1));
Theta2(3)=ccx2;Theta2(4)=ccy2;
% % source and orientation
% cx2 = Theta2(1);cy2 = Theta2(2);

s2 = sqrt(mean((Edge2(:,2)-cx2).^2+(Edge2(:,1)-cy2).^2));
NTheta2(1:2:3) = (Theta2(1:2:3)-cx2)/s2;
NTheta2(2:2:4) = (Theta2(2:2:4)-cy2)/s2;
nv2 = NTheta2(3:4)-NTheta2(1:2);
nv2 = nv2./norm(nv2);
nv2 = [nv2 0];
Edge2 = fliplr(Edge2);
NEdge2(:,1)= (Edge2(:,1)-cx2)/s2;NEdge2(:,2)= (Edge2(:,2)-cy2)/s2;
dtheta2 = VecAng(uv,v2);
NNTheta2 = [NTheta2(1:2) 0;NTheta2(3:4) 0];
r2 = vrrotvec(nv2, uv);
R2 = vrrotvec2mat(r2);
NNTheta2 = (R2*NNTheta2')';
nnv2 = NNTheta2(2,:)-NNTheta2(1,:);
NEdge2 = [NEdge2 zeros(size(NEdge2,1),1)];
NEdge2 = (R2*NEdge2')'; NEdge2 = NEdge2(:,1:2);NEdge2 = fliplr(NEdge2);
Edge2 = fliplr(Edge2);
% ------------------------------------------------------------------------
% hausdorff ditance for shape
[shd12 sD12] = HausdorffDist(NEdge1,NEdge2);
% ------------------------------------------------------------------------
% find point that the distances are taken
% 1 vs. 2
[i,j]=find(sD12==shd12);
p121 = NEdge1(i(ceil(length(i/2))),:);p122 = NEdge2(j(ceil(length(i/2))),:);
Line12X = [p121(2); p122(2)];
Line12Y = [p121(1); p122(1)];
% ------------------------------------------------------------------------
fS = figure;
plot(NEdge1(:,2),NEdge1(:,1),'r-',NEdge2(:,2),NEdge2(:,1),'b-'...
    ,'LineWidth',2);
hold on;
quiver(NNTheta1(1,1),NNTheta1(1,2),nnv1(1),nnv1(2),'r','LineWidth',5);
quiver(NNTheta2(1,1),NNTheta2(1,2),nnv2(1),nnv2(2),'b','LineWidth',5);
plot(0,0,'.g','MarkerSize',50);
plot(Line12X,Line12Y,'-g',...
     'LineWidth',5);
hold off;
set(gca,'YDir','reverse');
title(sprintf('sdh12=%f',shd12));

%% ------------------------------------------------------------------------
% test function

Theta = [T(5,:);T(11,:)]; % E - center lobe
Edge = [Edges(5,:); Edges(11,:)];

[D] = GenProx(Theta,Edge);

