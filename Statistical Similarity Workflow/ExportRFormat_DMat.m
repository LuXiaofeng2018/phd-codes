close all;clc;clear
run('EnviSetting');
%% ------------------------------------------------------------------------
% Summer
% DataName = 'Summer';
DataName = 'WCD';
% DataName = 'Borneo';
load(DataName);
% ------------------------------------------------------------------------
% Compute proximity matrix
ns = size(SP,1);
% assigne space
MatSPProx = zeros(ns);
MatThetaProx = zeros(ns);
MatPolyProx = zeros(ns);
MatShapeProx = zeros(ns);
for i=1:ns
    for j=i:ns
        Theta = [T(i,:); T(j,:)];
        Edge = [Edges(i); Edges(j)];
        D = GenProx(Theta, Edge);
        MatSPProx(i,j) = D(1);
        MatThetaProx(i,j) = D(2);
        MatPolyProx(i,j) = D(3);
        MatShapeProx(i,j) = D(4);
        sprintf('i=%d, j=%d',i,j)
        MatSPProx(j,i) = D(1);
        MatThetaProx(j,i) = D(2);
        MatPolyProx(j,i) = D(3);
        MatShapeProx(j,i) = D(4);
    end
end
% construct the min NND array
% t1 = MatSPProx;
% t2 = MatThetaProx;
% t3 = MatPolyProx;
% t4 = MatShapeProx;
% t1(t1==0)=Inf;
% t2(t2==0)=Inf;
% t3(t3==0)=Inf;
% t3(t3==0)=Inf;
%
NND = zeros(ns,4);
%
for i=1:ns
    % SP
    tt = MatSPProx(i,:);
    tt = sort(tt);
    NND(i,1) = tt(2);
    % Theta
    tt = MatThetaProx(i,:);
    tt = sort(tt);
    NND(i,2) = tt(2);
    % Poly
    tt = MatPolyProx(i,:);
    tt = sort(tt);
    NND(i,3) = tt(2);
    % Shape
    tt = MatShapeProx(i,:);
    tt = sort(tt);
    NND(i,4) = tt(2);
    i
end
% normalize NND
maxNND = max(NND,[],1);
for i=1:size(NND,2)
    norm_NND(:,i) = NND(:,i)/maxNND(:,i);
end

% ------------------------------------------------------------------------
% Save
save([DataName '_DMats'],'MatSPProx','MatThetaProx','MatPolyProx','MatShapeProx',...
    '-v7.3');
save([DataName '_NND'],'NND','norm_NND','-v7.3');
saveR([DataName '.R'],'SP','NND','norm_NND');

% % ------------------------------------------------------------------------
% % Save subset of summer
% clc;clear; close all;
% load('Summer.mat');load('Summer_NND.mat');
% SP = SP(1:212,:); NND = NND(1:212,:);norm_NND = norm_NND(1:212,:);
% save('subSummer_NND','SP','NND','norm_NND','-v7.3');
% saveR('subSummer.R','SP','NND','norm_NND');
% % ------------------------------------------------------------------------
% % Save subset of summer
% clc;clear; close all;
% load('WCD.mat');load('WCD_NND.mat');
% SP = SP(1:90,:); NND = NND(1:90,:);norm_NND = norm_NND(1:90,:);
% save('subWCD_NND','NND','norm_NND','-v7.3');
% saveR('subWCD.R','SP','NND','norm_NND');
