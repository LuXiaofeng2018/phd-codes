%% -------------------------------------------------------------------------
% This script lobe extracted information in TestWorkFlow1
% Cluster results, and extract lobes at different scales
% The results consist of a series of files, each are masks of lobes at its
% scale
% e.g. 
% 'Path\Scales\NewLobeSaveName.mat'

clc;close all;clear;
addpath(genpath('.\utilities\'));
% Exp. B
filename = 'WCD';
Path = '.\WCDCoarse\Extracted\';
% % Exp. A
% filename = 'Summer';
% Path = '.\SummerCoarse\Extracted\';

% -------------------------------------------------------------------------
load([Path filename '_PDMat']);
% -------------------------------------------------------------------------
% normalize all proximity values
normThetaD = MatThetaProx./max(MatThetaProx(:));
% -------------------------------------------------------------------------
% Fusing the distance, empirical weights
w1 = 0.4;
w2 = 0.2;
w3 = 0.3;
w4 = 0.1;

D = sqrt(w1*normSPD.^2 + w2*normThetaD.^2 + w3*normPolyD.^2 + w4*normShapeD.^2);
% -------------------------------------------------------------------------
% Hierarchical clustering
% calculate cumulated distance
SPDist = SeqPDist(D);
CtdzMZ = linkage(SPDist,'centroid');
% normalized the distance by its maximum
CtdzMZ(:,3)=CtdzMZ(:,3)/max(CtdzMZ(:,3));
% plot out result
figure;
% subplot(2,1,1);
[hden,dent,DenOrd]=dendrogram(CtdzMZ,0);
set(gca,'FontSize',35);
[CtdRD]=Dendro2RP(CtdzMZ,DenOrd');
figure;
% subplot(2,1,2);
bar(CtdRD);
% set(gca,'XTick',[1:size(CtdRD,1)],'XTickLabel',DenOrd);
% axis([0 length(DenOrd) 0 0.06]);
ylim([0 0.08]);
set(gca,'XTick',[],'XTickLabel',[]);
set(gca,'FontSize',35);
% title('Tank B','FontSize',35);
axis tight;
%% -------------------------------------------------------------------------
% Choose scale-of-interpretation in the hierarchy
CtdCut0 = 0.06;% Starting scale on Y-axis of dendrogram/reachability plot
CutOffset = 0.001;% Increasement on the Y-axis starting from CtdCut0
%% -------------------------------------------------------------------------

%
CtdCutArray = [CtdCut0:-CutOffset:CutOffset];%[0:CutOffset:CtdCut0];%
fNL = figure;
load([Path filename '_Extr']);
OldMasks = Masks;
for kk=1:length(CtdCutArray)
    CtdCut = CtdCutArray(kk);
    CtdIdxCut = CtdRD>CtdCut;
    CtdIdx = -1*ones(size(CtdRD));
    [CtdICut] = find(CtdIdxCut);
    nc = length(CtdICut);
    for i=1:nc-1
        CtdIdx(CtdICut(i):CtdICut(i+1)-1)=i;
    end
    CtdIdx(CtdICut(end):end)=(i+1);
    sprintf('Number of Clusters: %d, length:%f',length(unique(CtdIdx)),CtdCut)
    %% -------------------------------------------------------------------------
    % combine lobes in each group
%     load([Path filename]);
    NewLobeMask = cell(nc,1);
    [ny,nx]=size(cell2mat(OldMasks(1)));
    for i=1:nc
        idxi = sort(DenOrd(CtdIdx==i));
        groupi = OldMasks(idxi);
        Lobei = cell2mat(groupi(1));
%         figure(fNL);
%         imagesc(Lobei);
        for j=2:length(groupi)
            Lobe = cell2mat(groupi(j));
%             figure(fNL);
%             imagesc(Lobe);
            Lobei = Lobe|Lobei;
%             figure(fNL);
%             imagesc(Lobei);
        end
        Lobei(Lobei>0)=1;
%         figure(fNL);
%         imagesc(Lobei);
%         title(sprintf('Group#: %d(%d)',i,nc));
        NewLobeMask(i)={Lobei};
        sprintf('#length=%d, #Group=%d(%d)',kk,i,nc)
    end
    % -------------------------------------------------------------------------
    % Save New Lobes
    SclPath = [Path 'Scales\'];
    if (~exist(SclPath,'dir'))
        mkdir(SclPath)
    end
    NewLobeSaveName = [sprintf('%1.3fCut_%dGroups',CtdCut,nc) filename ];
    save([SclPath NewLobeSaveName '.mat'],'NewLobeMask','DenOrd','CtdIdx',...
        'CtdCut','-v7.3');
end
